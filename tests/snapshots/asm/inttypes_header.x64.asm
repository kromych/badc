
inttypes_header.x64:	file format elf64-x86-64

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
               	subq	$0x150, %rsp            # imm = 0x150
               	movabsq	$-0x4, %rax
               	movq	%rax, -0x20(%rbp)
               	movl	$0x4, %eax
               	movq	%rax, -0x40(%rbp)
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rcx
               	cmpq	$0x6c, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsbq	0x1(%rax), %rcx
               	cmpq	$0x6c, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	0x2(%rax), %rcx
               	cmpq	$0x64, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsbq	0x3(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1e, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rcx
               	cmpq	$0x6c, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsbq	0x1(%rax), %rcx
               	cmpq	$0x6c, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	0x2(%rax), %rcx
               	cmpq	$0x75, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsbq	0x3(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1f, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rcx
               	cmpq	$0x6c, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsbq	0x1(%rax), %rcx
               	cmpq	$0x6c, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	0x2(%rax), %rcx
               	cmpq	$0x78, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsbq	0x3(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x20, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rax
               	cmpq	$0x64, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	0x1(%rcx), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rcx
               	cmpq	$0x68, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsbq	0x1(%rax), %rcx
               	cmpq	$0x68, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	0x2(%rax), %rcx
               	cmpq	$0x64, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsbq	0x3(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x22, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rax
               	cmpq	$0x68, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	0x1(%rcx), %rax
               	cmpq	$0x64, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	0x2(%rcx), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x23, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rcx
               	cmpq	$0x6c, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsbq	0x1(%rax), %rcx
               	cmpq	$0x6c, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	0x2(%rax), %rcx
               	cmpq	$0x64, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsbq	0x3(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x24, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rcx
               	cmpq	$0x6c, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsbq	0x1(%rax), %rcx
               	cmpq	$0x6c, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	0x2(%rax), %rcx
               	cmpq	$0x64, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsbq	0x3(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x25, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xb, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	movl	$0xc, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	movl	$0xd, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	movl	$0xe, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	movl	$0xf, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	movl	$0x10, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	movl	$0x11, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	movl	$0x12, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	movl	$0x13, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	movl	$0x14, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	movl	$0x15, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	movl	$0x16, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
