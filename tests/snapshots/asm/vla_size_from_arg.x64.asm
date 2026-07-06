
vla_size_from_arg.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<fill_and_sum>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2030, %rsp           # imm = 0x2030
               	leaq	-0x30(%rbp), %r10
               	movq	%r10, (%r10)
               	movl	%edi, 0x10(%rbp)
               	movslq	0x10(%rbp), %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	leaq	-0x30(%rbp), %r11
               	movq	(%r11), %rax
               	subq	%r10, %rax
               	leaq	-0x2000(%r11), %r10
               	cmpq	%r10, %rax
               	jae	<addr>
               	ud2
               	movq	%rax, (%r11)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rax, %rax
               	movl	%eax, -0x18(%rbp)
               	jmp	<addr>
               	movq	-0x8(%rbp), %rax
               	movslq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	incq	%rcx
               	movslq	%ecx, %rdx
               	movb	%dl, (%rax)
               	movslq	-0x18(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x18(%rbp)
               	movslq	-0x18(%rbp), %rax
               	movslq	0x10(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jl	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x20(%rbp)
               	movl	%eax, -0x28(%rbp)
               	jmp	<addr>
               	movslq	-0x20(%rbp), %rax
               	movq	-0x8(%rbp), %rcx
               	movslq	-0x28(%rbp), %rdx
               	addq	%rdx, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movl	%eax, -0x20(%rbp)
               	movslq	-0x28(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x28(%rbp)
               	movslq	-0x28(%rbp), %rax
               	movslq	0x10(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jl	<addr>
               	movslq	-0x20(%rbp), %rax
               	addq	$0x2030, %rsp           # imm = 0x2030
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpq	$0x37, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
