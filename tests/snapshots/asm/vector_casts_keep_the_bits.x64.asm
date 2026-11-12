
vector_casts_keep_the_bits.x64:	file format elf64-x86-64

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
               	movabsq	$0x700000005, %r11      # imm = 0x700000005
               	vmovq	%r11, %xmm0
               	vpbroadcastq	%xmm0, %xmm0
               	vmovq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	jne	<addr>
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	vpextrw	$0x0, %xmm0, %eax
               	movswq	%ax, %rax
               	cmpq	$0x5, %rax
               	jne	<addr>
               	vpextrw	$0x1, %xmm0, %eax
               	movswq	%ax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	vpextrw	$0x2, %xmm0, %eax
               	movswq	%ax, %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	vpextrw	$0x3, %xmm0, %eax
               	movswq	%ax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%eax, %eax
               	retq
               	movl	$0x1, %eax
               	retq
