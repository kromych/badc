
packed_bitfield_repack.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rcx
               	andq	$-0x100, %rcx
               	orq	$0x55, %rcx
               	movb	%cl, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x7, %edx
               	movb	%dl, 0x1(%rax)
               	movq	%rcx, %rax
               	andq	$0xff, %rax
               	movsbq	%al, %rax
               	cmpq	$0x55, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x30, %rsp
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
               	movl	$0x9, %edx
               	movb	%dl, 0x4(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0x1ffff, %rax          # imm = 0x1FFFF
               	shlq	$0x2f, %rax
               	sarq	$0x2f, %rax
               	cmpq	$0xfde8, %rax           # imm = 0xFDE8
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	sarq	%rax
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
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x30, %rsp
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
               	movl	$0x4, %edx
               	movb	%dl, 0x2(%rax)
               	leaq	-0x18(%rbp), %rax
               	movzbq	(%rax), %rax
               	andq	$0x7, %rax
               	shlq	$0x3d, %rax
               	sarq	$0x3d, %rax
               	cmpq	$0x3, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
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
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x30, %rsp
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
               	movq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movswq	%ax, %rax
               	cmpq	$0x7530, %rax           # imm = 0x7530
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x30, %rsp
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
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	movl	$0x6, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x28(%rbp), %rax
               	movl	(%rax), %ecx
               	movabsq	$-0xffffff01, %r11      # imm = 0xFFFFFFFF000000FF
               	andq	%r11, %rcx
               	movl	$0xabcdef00, %r11d      # imm = 0xABCDEF00
               	orq	%r11, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x28(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x6, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	%ecx, %eax
               	sarq	$0x8, %rax
               	andq	$0xffffff, %rax         # imm = 0xFFFFFF
               	xorq	$0xabcdef, %rax         # imm = 0xABCDEF
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
