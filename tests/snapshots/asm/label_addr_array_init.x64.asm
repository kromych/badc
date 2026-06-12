
label_addr_array_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<run>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movslq	%edi, %rdi
               	movl	%edi, 0x10(%rbp)
               	leaq	<rip>, %rax        # <addr>
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax        # <addr>
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, 0x8(%rcx)
               	leaq	<rip>, %rax        # <addr>
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, 0x10(%rcx)
               	xorq	%rax, %rax
               	movl	%eax, -0x20(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movslq	0x10(%rbp), %rcx
               	movq	(%rax,%rcx,8), %rax
               	jmpq	*%rax
               	movl	$0xa, %eax
               	movl	%eax, -0x20(%rbp)
               	jmp	<addr>
               	movl	$0x14, %eax
               	movl	%eax, -0x20(%rbp)
               	jmp	<addr>
               	movl	$0x1e, %eax
               	movl	%eax, -0x20(%rbp)
               	movslq	-0x20(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
