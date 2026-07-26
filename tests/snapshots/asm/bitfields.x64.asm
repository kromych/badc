
bitfields.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x2, %rcx
               	orq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rdx
               	movl	%ecx, %eax
               	andq	$-0x3, %rax
               	orq	$0x0, %rax
               	movl	%eax, (%rdx)
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, %eax
               	andq	$-0x1d, %rax
               	orq	$0x14, %rax
               	movl	%eax, (%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, %eax
               	andq	$-0x3e1, %rax           # imm = 0xFC1F
               	orq	$0x220, %rax            # imm = 0x220
               	movl	%eax, (%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movl	0x4(%rcx), %edx
               	movabsq	$-0x100000000, %r11     # imm = 0xFFFFFFFF00000000
               	andq	%r11, %rdx
               	orq	$0x12345678, %rdx       # imm = 0x12345678
               	movl	%edx, 0x4(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x3e7, %esi            # imm = 0x3E7
               	movl	%esi, 0x8(%rcx)
               	movl	%eax, %ecx
               	andq	$0x1, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, %ecx
               	sarq	%rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, %ecx
               	sarq	$0x2, %rcx
               	andq	$0x7, %rcx
               	cmpq	$0x5, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, %ecx
               	sarq	$0x5, %rcx
               	andq	$0x1f, %rcx
               	cmpq	$0x11, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	%edx, %ecx
               	xorq	$0x12345678, %rcx       # imm = 0x12345678
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, %eax
               	andq	$-0x2, %rax
               	orq	$0x0, %rax
               	movl	%eax, (%rcx)
               	movl	%eax, %ecx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, %ecx
               	sarq	%rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, %ecx
               	sarq	$0x2, %rcx
               	andq	$0x7, %rcx
               	cmpq	$0x5, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, %ecx
               	sarq	$0x5, %rcx
               	andq	$0x1f, %rcx
               	cmpq	$0x11, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	%edx, %ecx
               	xorq	$0x12345678, %rcx       # imm = 0x12345678
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, %eax
               	andq	$-0x1d, %rax
               	orq	$0x1c, %rax
               	movl	%eax, (%rcx)
               	movl	%eax, %ecx
               	sarq	$0x2, %rcx
               	andq	$0x7, %rcx
               	cmpq	$0x7, %rcx
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, %ecx
               	sarq	$0x5, %rcx
               	andq	$0x1f, %rcx
               	cmpq	$0x11, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, %eax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x2, %rcx
               	orq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rdx
               	movl	%ecx, %eax
               	andq	$-0x3, %rax
               	orq	$0x2, %rax
               	movl	%eax, (%rdx)
               	leaq	-0x18(%rbp), %rcx
               	movl	%eax, %eax
               	andq	$-0x5, %rax
               	orq	$0x0, %rax
               	movl	%eax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movl	%eax, %eax
               	andq	$-0x9, %rax
               	orq	$0x8, %rax
               	movl	%eax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movl	%eax, %eax
               	andq	$-0xf1, %rax
               	orq	$0xb0, %rax
               	movl	%eax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movl	%eax, %eax
               	andq	$-0xff01, %rax          # imm = 0xFFFF00FF
               	orq	$0xc800, %rax           # imm = 0xC800
               	movl	%eax, (%rcx)
               	movl	%eax, %ecx
               	andq	$0x1, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, %ecx
               	sarq	%rcx
               	andq	$0x1, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, %ecx
               	sarq	$0x2, %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, %ecx
               	sarq	$0x3, %rcx
               	andq	$0x1, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, %ecx
               	sarq	$0x4, %rcx
               	andq	$0xf, %rcx
               	cmpq	$0xb, %rcx
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, %ecx
               	sarq	$0x8, %rcx
               	andq	$0xff, %rcx
               	cmpq	$0xc8, %rcx
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rdx
               	movl	%eax, %ecx
               	sarq	$0x8, %rcx
               	andq	$0xff, %rcx
               	incq	%rcx
               	movslq	%ecx, %rcx
               	andq	$0xff, %rcx
               	movl	%eax, %eax
               	andq	$-0xff01, %rax          # imm = 0xFFFF00FF
               	shlq	$0x8, %rcx
               	orq	%rcx, %rax
               	movl	%eax, (%rdx)
               	movl	%eax, %eax
               	sarq	$0x8, %rax
               	andq	$0xff, %rax
               	cmpq	$0xc9, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
