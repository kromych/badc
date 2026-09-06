
tailcall_return_extension.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<load_le32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%esi, %rsi
               	cmpl	$0x4, %esi
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	(%rdi,%rsi), %rax
               	movzbq	(%rax), %rcx
               	movq	%rsi, %rax
               	shlq	$0x3, %rax
               	movslq	%eax, %rax
               	movq	%rcx, %rbx
               	pushq	%rcx
               	movq	%rax, %rcx
               	shlq	%cl, %rbx
               	popq	%rcx
               	incq	%rsi
               	callq	<addr>
               	orq	%rbx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq

<get_long>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rsi, %rsi
               	callq	<addr>
               	movl	%eax, %eax
               	popq	%rbp
               	retq

<widen>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rsi, %rsi
               	callq	<addr>
               	movl	%eax, %eax
               	popq	%rbp
               	retq

<load_alias>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rsi, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xfe, %eax
               	movl	$0x7f, %ebx
               	leaq	-0x8(%rbp), %rdi
               	xorq	%rcx, %rcx
               	movb	%cl, (%rdi)
               	movl	$0x10, %ecx
               	movb	%cl, 0x1(%rdi)
               	movl	$0xbf, %ecx
               	movb	%cl, 0x2(%rdi)
               	movb	%al, 0x3(%rdi)
               	xorq	%rsi, %rsi
               	callq	<addr>
               	movl	%eax, %eax
               	movl	$0xfebf1000, %r11d      # imm = 0xFEBF1000
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x8(%rbp), %rdi
               	xorq	%rsi, %rsi
               	callq	<addr>
               	cmpl	$0xfebf1000, %eax       # imm = 0xFEBF1000
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x8(%rbp), %rdi
               	movb	%bl, 0x3(%rdi)
               	xorq	%rsi, %rsi
               	callq	<addr>
               	movl	%eax, %eax
               	cmpl	$0x7fbf1000, %eax       # imm = 0x7FBF1000
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
