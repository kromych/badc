
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
               	leaq	-0x8(%rbp), %rcx
               	movl	(%rcx), %eax
               	andq	$-0x20000, %rax         # imm = 0xFFFE0000
               	orq	$0xfde8, %rax           # imm = 0xFDE8
               	movl	%eax, (%rcx)
               	movzwq	0x2(%rcx), %rax
               	andq	$-0x7ff, %rax           # imm = 0xF801
               	movq	%rax, %rdx
               	orq	$0x3e8, %rdx            # imm = 0x3E8
               	movw	%dx, 0x2(%rcx)
               	movl	$0x9, %eax
               	movb	%al, -0x4(%rbp)
               	movl	(%rcx), %esi
               	andq	$0x1ffff, %rsi          # imm = 0x1FFFF
               	shlq	$0x2f, %rsi
               	sarq	$0x2f, %rsi
               	cmpl	$0xfde8, %esi           # imm = 0xFDE8
               	jne	<addr>
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	sarq	%rdx
               	andq	$0x3ff, %rdx            # imm = 0x3FF
               	shlq	$0x36, %rdx
               	sarq	$0x36, %rdx
               	cmpl	$0x1f4, %edx            # imm = 0x1F4
               	jne	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	andq	$-0x8, %rdx
               	orq	$0x3, %rdx
               	movb	%dl, -0x8(%rbp)
               	movzwq	(%rcx), %rdx
               	andq	$-0x3f9, %rdx           # imm = 0xFC07
               	orq	$0x1e0, %rdx            # imm = 0x1E0
               	movw	%dx, (%rcx)
               	movb	$0x4, -0x6(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movzbq	-0x8(%rbp), %rsi
               	andq	$0x7, %rsi
               	shlq	$0x3d, %rsi
               	sarq	$0x3d, %rsi
               	cmpl	$0x3, %esi
               	jne	<addr>
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	sarq	$0x3, %rdx
               	andq	$0x7f, %rdx
               	shlq	$0x39, %rdx
               	sarq	$0x39, %rdx
               	cmpl	$0x3c, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx      # <addr>
               	movzbq	(%rdx), %rsi
               	movsbq	%sil, %rsi
               	cmpl	$0x55, %esi
               	jne	<addr>
               	movsbq	0x1(%rdx), %rdx
               	cmpl	$0x7, %edx
               	je	<addr>
               	leave
               	retq
               	movb	$0x6, -0x8(%rbp)
               	movl	(%rcx), %eax
               	movabsq	$-0xffffff01, %r11      # imm = 0xFFFFFFFF000000FF
               	andq	%r11, %rax
               	movl	$0xabcdef00, %r11d      # imm = 0xABCDEF00
               	orq	%r11, %rax
               	movl	%eax, (%rcx)
               	movsbq	-0x8(%rbp), %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movl	%eax, %eax
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
