
packed_bitfield_struct_by_value.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x28, %rsp
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x7ffffffe0000001, %r11 # imm = 0xF80000001FFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x555555540000000, %r11 # imm = 0x555555540000000
               	orq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, 0x18(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movq	%rax, (%rcx)
               	movq	<rip>, %rax # <addr>
               	sarq	$0x1d, %rax
               	andq	$0x3fffffff, %rax       # imm = 0x3FFFFFFF
               	cmpl	$0x2aaaaaaa, %eax       # imm = 0x2AAAAAAA
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	andq	$-0x20000000, %rax      # imm = 0xE0000000
               	orq	$0x1ffffffb, %rax       # imm = 0x1FFFFFFB
               	movl	%eax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x7ffffffe0000001, %r11 # imm = 0xF80000001FFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x9a0000000, %r11      # imm = 0x9A0000000
               	orq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	shlq	$0x23, %rcx
               	sarq	$0x23, %rcx
               	cmpl	$-0x5, %ecx
               	jne	<addr>
               	sarq	$0x1d, %rax
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$0x4d, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	andq	$-0x100000, %rcx        # imm = 0xFFF00000
               	orq	$0xfffff, %rcx          # imm = 0xFFFFF
               	movl	%ecx, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	movabsq	$-0xfffffffffff1, %r11  # imm = 0xFFFF00000000000F
               	andq	%r11, %rcx
               	movabsq	$0x7ffffffffff0, %r11   # imm = 0x7FFFFFFFFFF0
               	orq	%r11, %rcx
               	movq	%rcx, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	andq	$-0x100000, %rcx        # imm = 0xFFF00000
               	orq	$0xabcde, %rcx          # imm = 0xABCDE
               	movl	%ecx, <rip> # <addr>
               	movb	$0x9, <rip> # <addr>
               	leaq	0x10(%rsp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rcx)
               	movzbq	<rip>, %rax # <addr>
               	incq	%rax
               	movb	%al, 0x1b(%rsp)
               	movq	0x10(%rsp), %rcx
               	movl	0x18(%rsp), %eax
               	movq	%rcx, (%rsp)
               	movl	%eax, 0x8(%rsp)
               	movl	(%rsp), %ecx
               	andq	$0xfffff, %rcx          # imm = 0xFFFFF
               	cmpl	$0xfffff, %ecx          # imm = 0xFFFFF
               	jne	<addr>
               	movq	0x2(%rsp), %rcx
               	sarq	$0x4, %rcx
               	movabsq	$0xfffffffffff, %r11    # imm = 0xFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x7ffffffffff, %r11    # imm = 0x7FFFFFFFFFF
               	cmpq	%r11, %rcx
               	jne	<addr>
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	cmpl	$0xabcde, %eax          # imm = 0xABCDE
               	jne	<addr>
               	movzbq	0xb(%rsp), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
