
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
               	movl	-0x8(%rbp), %eax
               	andq	$-0x20000, %rax         # imm = 0xFFFE0000
               	orq	$0xfde8, %rax           # imm = 0xFDE8
               	movl	%eax, -0x8(%rbp)
               	movzwq	-0x6(%rbp), %rax
               	andq	$-0x7ff, %rax           # imm = 0xF801
               	movq	%rax, %rcx
               	orq	$0x3e8, %rcx            # imm = 0x3E8
               	movw	%cx, -0x6(%rbp)
               	movl	$0x9, %eax
               	movb	%al, -0x4(%rbp)
               	movl	-0x8(%rbp), %edx
               	shlq	$0x2f, %rdx
               	sarq	$0x2f, %rdx
               	cmpl	$0xfde8, %edx           # imm = 0xFDE8
               	jne	<addr>
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	sarq	%rcx
               	shlq	$0x36, %rcx
               	sarq	$0x36, %rcx
               	cmpl	$0x1f4, %ecx            # imm = 0x1F4
               	jne	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	andq	$-0x8, %rcx
               	orq	$0x3, %rcx
               	movb	%cl, -0x8(%rbp)
               	movzwq	-0x8(%rbp), %rcx
               	andq	$-0x3f9, %rcx           # imm = 0xFC07
               	orq	$0x1e0, %rcx            # imm = 0x1E0
               	movw	%cx, -0x8(%rbp)
               	movb	$0x4, -0x6(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	shlq	$0x3d, %rdx
               	sarq	$0x3d, %rdx
               	cmpl	$0x3, %edx
               	jne	<addr>
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	sarq	$0x3, %rcx
               	shlq	$0x39, %rcx
               	sarq	$0x39, %rcx
               	cmpl	$0x3c, %ecx
               	jne	<addr>
               	movzbq	<rip>, %rcx # <addr>
               	movsbq	%cl, %rcx
               	cmpl	$0x55, %ecx
               	jne	<addr>
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	$0x7, %ecx
               	je	<addr>
               	leave
               	retq
               	movb	$0x6, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	movabsq	$-0xffffff01, %r11      # imm = 0xFFFFFFFF000000FF
               	andq	%r11, %rax
               	movl	$0xabcdef00, %r11d      # imm = 0xABCDEF00
               	orq	%r11, %rax
               	movl	%eax, -0x8(%rbp)
               	movsbq	-0x8(%rbp), %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movl	%eax, %eax
               	sarq	$0x8, %rax
               	cmpl	$0xabcdef, %eax         # imm = 0xABCDEF
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
