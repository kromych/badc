
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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movslq	%esi, %rsi
               	cmpl	$0x4, %esi
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movzbq	(%rdi,%rsi), %rax
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	movq	%rax, %rbx
               	shlq	%cl, %rbx
               	incq	%rsi
               	callq	<addr>
               	orq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq

<get_long>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%esi, %esi
               	callq	<addr>
               	popq	%rbp
               	retq

<widen>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%esi, %esi
               	callq	<addr>
               	movl	%eax, %eax
               	popq	%rbp
               	retq

<load_alias>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%esi, %esi
               	callq	<addr>
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rdi
               	movb	$0x0, (%rdi)
               	movb	$0x10, 0x1(%rdi)
               	movb	$-0x41, 0x2(%rdi)
               	movb	$-0x2, 0x3(%rdi)
               	xorl	%esi, %esi
               	callq	<addr>
               	movl	$0xfebf1000, %r11d      # imm = 0xFEBF1000
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpl	$0xfebf1000, %eax       # imm = 0xFEBF1000
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rdi
               	movb	$0x7f, 0x3(%rdi)
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpl	$0x7fbf1000, %eax       # imm = 0x7FBF1000
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
