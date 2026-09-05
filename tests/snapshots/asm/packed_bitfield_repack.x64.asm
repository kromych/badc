
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
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rcx
               	andq	$-0x100, %rcx
               	orq	$0x55, %rcx
               	movb	%cl, (%rax)
               	movl	$0x7, %edx
               	movb	%dl, 0x1(%rax)
               	andq	$0xff, %rcx
               	movsbq	%cl, %rcx
               	cmpl	$0x55, %ecx
               	jne	<addr>
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	movl	(%rax), %ecx
               	andq	$-0x20000, %rcx         # imm = 0xFFFE0000
               	orq	$0xfde8, %rcx           # imm = 0xFDE8
               	movl	%ecx, (%rax)
               	movzwq	0x2(%rax), %rcx
               	andq	$-0x7ff, %rcx           # imm = 0xF801
               	orq	$0x3e8, %rcx            # imm = 0x3E8
               	movw	%cx, 0x2(%rax)
               	movl	$0x9, %esi
               	movb	%sil, 0x4(%rax)
               	movl	(%rax), %eax
               	andq	$0x1ffff, %rax          # imm = 0x1FFFF
               	shlq	$0x2f, %rax
               	sarq	$0x2f, %rax
               	cmpq	$0xfde8, %rax           # imm = 0xFDE8
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
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rcx
               	andq	$-0x8, %rcx
               	orq	$0x3, %rcx
               	movb	%cl, (%rax)
               	movzwq	(%rax), %rcx
               	andq	$-0x3f9, %rcx           # imm = 0xFC07
               	orq	$0x1e0, %rcx            # imm = 0x1E0
               	movw	%cx, (%rax)
               	movl	$0x4, %edx
               	movb	%dl, 0x2(%rax)
               	movzbq	(%rax), %rdx
               	andq	$0x7, %rdx
               	shlq	$0x3d, %rdx
               	sarq	$0x3d, %rdx
               	cmpq	$0x3, %rdx
               	jne	<addr>
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	sarq	$0x3, %rcx
               	andq	$0x7f, %rcx
               	shlq	$0x39, %rcx
               	sarq	$0x39, %rcx
               	cmpq	$0x3c, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	movl	$0xb, %edx
               	movb	%dl, (%rax)
               	leaq	0x1(%rax), %rdx
               	movzwq	(%rdx), %rsi
               	andq	$-0x10000, %rsi         # imm = 0xFFFF0000
               	orq	$0x7530, %rsi           # imm = 0x7530
               	movw	%si, (%rdx)
               	movq	%rsi, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movswq	%dx, %rdx
               	cmpl	$0x7530, %edx           # imm = 0x7530
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx
               	movzbq	(%rdx), %rdx
               	movsbq	%dl, %rdx
               	cmpl	$0x55, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movsbq	0x1(%rdx), %rdx
               	cmpl	$0x7, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6, %edx
               	movb	%dl, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %edx
               	movabsq	$-0xffffff01, %r11      # imm = 0xFFFFFFFF000000FF
               	andq	%r11, %rdx
               	movl	$0xabcdef00, %r11d      # imm = 0xABCDEF00
               	orq	%r11, %rdx
               	movl	%edx, (%rax)
               	movsbq	(%rax), %rax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movl	%edx, %eax
               	sarq	$0x8, %rax
               	andq	$0xffffff, %rax         # imm = 0xFFFFFF
               	xorq	$0xabcdef, %rax         # imm = 0xABCDEF
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
