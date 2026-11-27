
bitfield_typedef_alignment.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	movabsq	$0x6000000000005, %rax  # imm = 0x6000000000005
               	movq	%rax, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	movabsq	$-0xffffffffff01, %r11  # imm = 0xFFFF0000000000FF
               	andq	%r11, %rax
               	movabsq	$0xfedcba987700, %r11   # imm = 0xFEDCBA987700
               	orq	%r11, %rax
               	movq	%rax, 0x8(%rsp)
               	movsbq	0x8(%rsp), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	sarq	$0x8, %rax
               	shlq	$0x18, %rax
               	sarq	$0x18, %rax
               	movabsq	$-0x123456789, %r11     # imm = 0xFFFFFFFEDCBA9877
               	cmpq	%r11, %rax
               	jne	<addr>
               	movsbq	0xe(%rsp), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
