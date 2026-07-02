
vla_runtime_sizeof.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2030, %rsp           # imm = 0x2030
               	leaq	-0x28(%rbp), %r10
               	movq	%r10, (%r10)
               	movl	$0x7, %eax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	shlq	$0x3, %rax
               	movq	%rax, -0x18(%rbp)
               	movq	%rax, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	leaq	-0x28(%rbp), %r11
               	movq	(%r11), %rax
               	subq	%r10, %rax
               	leaq	-0x2000(%r11), %r10
               	cmpq	%r10, %rax
               	jae	<addr>
               	ud2
               	movq	%rax, (%r11)
               	movq	%rax, -0x10(%rbp)
               	movq	-0x18(%rbp), %rax
               	movq	%rax, -0x20(%rbp)
               	movq	-0x20(%rbp), %rax
               	movslq	-0x8(%rbp), %rcx
               	shlq	$0x3, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x2030, %rsp           # imm = 0x2030
               	popq	%rbp
               	retq
               	movq	-0x20(%rbp), %rax
               	shrq	$0x3, %rax
               	movslq	-0x8(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x2030, %rsp           # imm = 0x2030
               	popq	%rbp
               	retq
               	movl	$0x64, %eax
               	movl	%eax, -0x8(%rbp)
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x38, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x2030, %rsp           # imm = 0x2030
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x2030, %rsp           # imm = 0x2030
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
