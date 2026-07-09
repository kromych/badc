
packed_bitfield_repack.x64:	file format elf64-x86-64

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
               	subq	$0x70, %rsp
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rcx
               	andq	$-0x100, %rcx
               	orq	$0x55, %rcx
               	movb	%cl, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x7, %ecx
               	movb	%cl, 0x1(%rax)
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rax
               	movsbq	%al, %rax
               	cmpq	$0x55, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movsbq	0x1(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x20000, %rcx         # imm = 0xFFFE0000
               	orq	$0xfde8, %rcx           # imm = 0xFDE8
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movzwq	0x2(%rax), %rcx
               	andq	$-0x7ff, %rcx           # imm = 0xF801
               	orq	$0x3e8, %rcx            # imm = 0x3E8
               	movw	%cx, 0x2(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x9, %ecx
               	movb	%cl, 0x4(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0x1ffff, %rax          # imm = 0x1FFFF
               	shlq	$0x2f, %rax
               	sarq	$0x2f, %rax
               	cmpq	$0xfde8, %rax           # imm = 0xFDE8
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movzwq	0x2(%rax), %rax
               	sarq	$0x1, %rax
               	andq	$0x3ff, %rax            # imm = 0x3FF
               	shlq	$0x36, %rax
               	sarq	$0x36, %rax
               	cmpq	$0x1f4, %rax            # imm = 0x1F4
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movsbq	0x4(%rax), %rax
               	cmpq	$0x9, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movzbq	(%rax), %rcx
               	andq	$-0x8, %rcx
               	orq	$0x3, %rcx
               	movb	%cl, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0x3f9, %rcx           # imm = 0xFC07
               	orq	$0x1e0, %rcx            # imm = 0x1E0
               	movw	%cx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x4, %ecx
               	movb	%cl, 0x2(%rax)
               	leaq	-0x18(%rbp), %rax
               	movzbq	(%rax), %rax
               	andq	$0x7, %rax
               	shlq	$0x3d, %rax
               	sarq	$0x3d, %rax
               	cmpq	$0x3, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movzwq	(%rax), %rax
               	sarq	$0x3, %rax
               	andq	$0x7f, %rax
               	shlq	$0x39, %rax
               	sarq	$0x39, %rax
               	cmpq	$0x3c, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movsbq	0x2(%rax), %rax
               	cmpq	$0x4, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movl	$0xb, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x20(%rbp), %rax
               	incq	%rax
               	movzwq	(%rax), %rcx
               	andq	$-0x10000, %rcx         # imm = 0xFFFF0000
               	orq	$0x7530, %rcx           # imm = 0x7530
               	movw	%cx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0xb, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	incq	%rax
               	movzwq	(%rax), %rax
               	movswq	%ax, %rax
               	cmpq	$0x7530, %rax           # imm = 0x7530
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	movsbq	%al, %rax
               	cmpq	$0x55, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	0x1(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
