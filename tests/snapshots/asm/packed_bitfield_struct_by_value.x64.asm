
packed_bitfield_struct_by_value.x64:	file format elf64-x86-64

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

<ret_s>:
               	leaq	<rip>, %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	movabsq	$-0x7ffffffe0000001, %r11 # imm = 0xF80000001FFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x555555540000000, %r11 # imm = 0x555555540000000
               	orq	%r11, %rax
               	movq	%rax, (%rcx)
               	leaq	-0x8(%rbp), %rax
               	movzbq	0x3(%rcx), %rdx
               	movl	0x4(%rcx), %ecx
               	movb	%dl, 0x3(%rax)
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	sarq	$0x1d, %rax
               	andq	$0x3fffffff, %rax       # imm = 0x3FFFFFFF
               	cmpl	$0x2aaaaaaa, %eax       # imm = 0x2AAAAAAA
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	(%rax), %ecx
               	andq	$-0x20000000, %rcx      # imm = 0xE0000000
               	orq	$0x1ffffffb, %rcx       # imm = 0x1FFFFFFB
               	movl	%ecx, (%rax)
               	movq	(%rax), %rcx
               	movabsq	$-0x7ffffffe0000001, %r11 # imm = 0xF80000001FFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x9a0000000, %r11      # imm = 0x9A0000000
               	orq	%r11, %rcx
               	movq	%rcx, (%rax)
               	callq	<addr>
               	movq	%rax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	<rip>, %rax
               	movl	(%rax), %ecx
               	andq	$0x1fffffff, %rcx       # imm = 0x1FFFFFFF
               	shlq	$0x23, %rcx
               	sarq	$0x23, %rcx
               	cmpl	$-0x5, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	sarq	$0x1d, %rax
               	andq	$0x3fffffff, %rax       # imm = 0x3FFFFFFF
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$0x4d, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movl	(%rcx), %eax
               	andq	$-0x100000, %rax        # imm = 0xFFF00000
               	orq	$0xfffff, %rax          # imm = 0xFFFFF
               	movl	%eax, (%rcx)
               	movq	0x2(%rcx), %rax
               	movabsq	$-0xfffffffffff1, %r11  # imm = 0xFFFF00000000000F
               	andq	%r11, %rax
               	movabsq	$0x7ffffffffff0, %r11   # imm = 0x7FFFFFFFFFF0
               	orq	%r11, %rax
               	movq	%rax, 0x2(%rcx)
               	movl	0x8(%rcx), %eax
               	andq	$-0x100000, %rax        # imm = 0xFFF00000
               	orq	$0xabcde, %rax          # imm = 0xABCDE
               	movl	%eax, 0x8(%rcx)
               	movb	$0x9, 0xb(%rcx)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rax)
               	movzbq	0xb(%rax), %rcx
               	incq	%rcx
               	movb	%cl, 0xb(%rax)
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rax), %rsi
               	movl	0x8(%rax), %edx
               	movq	%rsi, (%rcx)
               	movl	%edx, 0x8(%rcx)
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rax)
               	movl	(%rax), %ecx
               	andq	$0xfffff, %rcx          # imm = 0xFFFFF
               	cmpl	$0xfffff, %ecx          # imm = 0xFFFFF
               	jne	<addr>
               	movq	0x2(%rax), %rcx
               	sarq	$0x4, %rcx
               	movabsq	$0xfffffffffff, %r11    # imm = 0xFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x7ffffffffff, %r11    # imm = 0x7FFFFFFFFFF
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movq	%rdx, %rcx
               	andq	$0xfffff, %rcx          # imm = 0xFFFFF
               	cmpl	$0xabcde, %ecx          # imm = 0xABCDE
               	jne	<addr>
               	movzbq	0xb(%rax), %rax
               	xorq	$0xa, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
