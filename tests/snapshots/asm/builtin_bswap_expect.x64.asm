
builtin_bswap_expect.x64:	file format elf64-x86-64

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
               	movl	$0xaabbccdd, %eax       # imm = 0xAABBCCDD
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	bswapl	%eax
               	movl	$0xddccbbaa, %r11d      # imm = 0xDDCCBBAA
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
