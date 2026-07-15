
tailcall_return_extension.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<load_le32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%esi, %rsi
               	cmpq	$0x4, %rsi
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
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
               	addq	$0x10, %rsp
               	popq	%rbp
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
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xfe, %ecx
               	movl	$0x7f, %ebx
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdx, %rdx
               	movb	%dl, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x10, %edx
               	movb	%dl, 0x1(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0xbf, %edx
               	movb	%dl, 0x2(%rax)
               	leaq	-0x18(%rbp), %rax
               	movb	%cl, 0x3(%rax)
               	leaq	-0x18(%rbp), %rdi
               	xorq	%rsi, %rsi
               	callq	<addr>
               	movl	%eax, %eax
               	movl	$0xfebf1000, %r11d      # imm = 0xFEBF1000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rdi
               	xorq	%rsi, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x140f000, %rax       # imm = 0xFEBF1000
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movb	%bl, 0x3(%rax)
               	leaq	-0x18(%rbp), %rdi
               	xorq	%rsi, %rsi
               	callq	<addr>
               	movl	%eax, %eax
               	cmpq	$0x7fbf1000, %rax       # imm = 0x7FBF1000
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
