
rotate_inline_const_count.x64:	file format elf64-x86-64

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
               	movabsq	$0x123456789abcdef, %rax # imm = 0x123456789ABCDEF
               	movq	%rax, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	rorxq	$0x1c, %rax, %rcx
               	rorxq	$0x22, %rax, %rdx
               	xorq	%rdx, %rcx
               	rorq	$0x27, %rax
               	xorq	%rax, %rcx
               	movabsq	$-0x483a85eff3813e55, %r11 # imm = 0xB7C57A100C7EC1AB
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
