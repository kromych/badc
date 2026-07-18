
label_addr_array_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<run_auto>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	%edi, 0x10(%rbp)
               	leaq	<rip>, %rax        # <addr>
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rcx        # <addr>
               	leaq	-0x18(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	<rip>, %rcx        # <addr>
               	leaq	-0x18(%rbp), %rax
               	movq	%rcx, 0x10(%rax)
               	xorq	%rax, %rax
               	movl	%eax, -0x20(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movslq	%edi, %rcx
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

<run_static>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, 0x10(%rbp)
               	leaq	<rip>, %rax
               	movsbq	0x18(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, 0x8(%rax)
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, 0x10(%rax)
               	movl	$0x1, %ecx
               	movb	%cl, 0x18(%rax)
               	movq	%rcx, -0x10(%rbp)
               	xorq	%rcx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movslq	0x10(%rbp), %rcx
               	movq	(%rax,%rcx,8), %rax
               	jmpq	*%rax
               	movl	$0x1, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movl	$0x2, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movl	$0x3, %eax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<run_static_const>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, 0x10(%rbp)
               	leaq	<rip>, %rax
               	movsbq	0x18(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, 0x8(%rax)
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, 0x10(%rax)
               	movl	$0x1, %ecx
               	movb	%cl, 0x18(%rax)
               	movq	%rcx, -0x10(%rbp)
               	xorq	%rcx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movslq	0x10(%rbp), %rcx
               	movq	(%rax,%rcx,8), %rax
               	jmpq	*%rax
               	movl	$0x64, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movl	$0xc8, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movl	$0x12c, %eax            # imm = 0x12C
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
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
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
