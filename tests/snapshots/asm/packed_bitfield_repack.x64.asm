
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
               	cmpq	$0x55, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	(%rax), %ecx
               	andq	$-0x20000, %rcx         # imm = 0xFFFE0000
               	orq	$0xfde8, %rcx           # imm = 0xFDE8
               	movl	%ecx, (%rax)
               	movzwq	0x2(%rax), %rcx
               	andq	$-0x7ff, %rcx           # imm = 0xF801
               	movq	%rcx, %rdx
               	orq	$0x3e8, %rdx            # imm = 0x3E8
               	movw	%dx, 0x2(%rax)
               	movl	$0x9, %ecx
               	movb	%cl, 0x4(%rax)
               	movl	(%rax), %ecx
               	andq	$0x1ffff, %rcx          # imm = 0x1FFFF
               	shlq	$0x2f, %rcx
               	sarq	$0x2f, %rcx
               	cmpq	$0xfde8, %rcx           # imm = 0xFDE8
               	movl	$0x1, %ecx
               	jne	<addr>
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	sarq	%rdx
               	andq	$0x3ff, %rdx            # imm = 0x3FF
               	shlq	$0x36, %rdx
               	sarq	$0x36, %rdx
               	cmpq	$0x1f4, %rdx            # imm = 0x1F4
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	xorq	%rdx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%rax), %rdx
               	andq	$-0x8, %rdx
               	orq	$0x3, %rdx
               	movb	%dl, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rdx
               	andq	$-0x3f9, %rdx           # imm = 0xFC07
               	orq	$0x1e0, %rdx            # imm = 0x1E0
               	movw	%dx, (%rax)
               	movl	$0x4, %esi
               	movb	%sil, 0x2(%rax)
               	movzbq	(%rax), %rsi
               	andq	$0x7, %rsi
               	shlq	$0x3d, %rsi
               	sarq	$0x3d, %rsi
               	cmpq	$0x3, %rsi
               	jne	<addr>
               	movq	%rdx, %rcx
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
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0xb, %ecx
               	movb	%cl, (%rax)
               	leaq	0x1(%rax), %rcx
               	movzwq	(%rcx), %rdx
               	andq	$-0x10000, %rdx         # imm = 0xFFFF0000
               	orq	$0x7530, %rdx           # imm = 0x7530
               	movw	%dx, (%rcx)
               	movq	%rdx, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movswq	%cx, %rcx
               	cmpq	$0x7530, %rcx           # imm = 0x7530
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %rcx
               	movsbq	%cl, %rcx
               	cmpq	$0x55, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movsbq	0x1(%rcx), %rcx
               	cmpq	$0x7, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %ecx
               	movabsq	$-0xffffff01, %r11      # imm = 0xFFFFFFFF000000FF
               	andq	%r11, %rcx
               	movl	$0xabcdef00, %r11d      # imm = 0xABCDEF00
               	orq	%r11, %rcx
               	movl	%ecx, (%rax)
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
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
