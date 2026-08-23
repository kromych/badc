
float_ternary_promote.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	movl	$0x3fc00000, %eax       # imm = 0x3FC00000
               	movl	$0x3fc00000, %r11d      # imm = 0x3FC00000
               	movq	%r11, %xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movq	%rax, %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movapd	%xmm0, %xmm1
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x40500000, %eax       # imm = 0x40500000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x18(%rbp,%riz)
               	movss	-0x18(%rbp,%riz), %xmm0
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jbe	<addr>
               	movss	-0x18(%rbp,%riz), %xmm0
               	movss	-0x18(%rbp,%riz), %xmm1
               	movq	%rax, %xmm15
               	ucomiss	%xmm1, %xmm15
               	jbe	<addr>
               	movss	-0x18(%rbp,%riz), %xmm1
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	addss	%xmm1, %xmm0
               	movl	$0x40d00000, %eax       # imm = 0x40D00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x41a00000, %eax       # imm = 0x41A00000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x8(%rbp,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	movl	$0x41a00000, %eax       # imm = 0x41A00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movss	-0x18(%rbp,%riz), %xmm1
               	jmp	<addr>
               	movss	-0x18(%rbp,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	jmp	<addr>
