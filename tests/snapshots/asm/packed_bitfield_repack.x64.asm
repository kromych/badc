
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
               	andq	$0xff, %rcx
               	movsbq	%cl, %rcx
               	cmpl	$0x55, %ecx
               	jne	<addr>
               	movl	(%rax), %ecx
               	andq	$-0x20000, %rcx         # imm = 0xFFFE0000
               	orq	$0xfde8, %rcx           # imm = 0xFDE8
               	movl	%ecx, (%rax)
               	movzwq	0x2(%rax), %rcx
               	andq	$-0x7ff, %rcx           # imm = 0xF801
               	orq	$0x3e8, %rcx            # imm = 0x3E8
               	movw	%cx, 0x2(%rax)
               	movl	$0x9, %edx
               	movb	%dl, 0x4(%rax)
               	movl	(%rax), %edx
               	andq	$0x1ffff, %rdx          # imm = 0x1FFFF
               	shlq	$0x2f, %rdx
               	sarq	$0x2f, %rdx
               	cmpq	$0xfde8, %rdx           # imm = 0xFDE8
               	jne	<addr>
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	sarq	%rcx
               	andq	$0x3ff, %rcx            # imm = 0x3FF
               	shlq	$0x36, %rcx
               	sarq	$0x36, %rcx
               	cmpq	$0x1f4, %rcx            # imm = 0x1F4
               	jne	<addr>
               	movzbq	(%rax), %rcx
               	andq	$-0x8, %rcx
               	orq	$0x3, %rcx
               	movb	%cl, (%rax)
               	leaq	-0x8(%rbp), %rax
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
               	jne	<addr>
               	leaq	0x1(%rax), %rcx
               	movzwq	(%rcx), %rdx
               	andq	$-0x10000, %rdx         # imm = 0xFFFF0000
               	orq	$0x7530, %rdx           # imm = 0x7530
               	movw	%dx, (%rcx)
               	movq	%rdx, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movswq	%cx, %rcx
               	cmpl	$0x7530, %ecx           # imm = 0x7530
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %rcx
               	movsbq	%cl, %rcx
               	cmpl	$0x55, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movsbq	0x1(%rcx), %rcx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x6, %ecx
               	movb	%cl, (%rax)
               	movl	(%rax), %ecx
               	movabsq	$-0xffffff01, %r11      # imm = 0xFFFFFFFF000000FF
               	andq	%r11, %rcx
               	movl	$0xabcdef00, %r11d      # imm = 0xABCDEF00
               	orq	%r11, %rcx
               	movl	%ecx, (%rax)
               	movsbq	(%rax), %rax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movl	%ecx, %eax
               	sarq	$0x8, %rax
               	xorq	$0xabcdef, %rax         # imm = 0xABCDEF
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x5, %eax
               	leave
               	retq
