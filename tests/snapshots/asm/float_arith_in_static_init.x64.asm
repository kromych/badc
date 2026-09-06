
float_arith_in_static_init.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movss	(%rax,%riz), %xmm0
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movss	0x4(%rax,%riz), %xmm0
               	movl	$0x40200000, %ecx       # imm = 0x40200000
               	movq	%rcx, %xmm1
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movss	0x8(%rax,%riz), %xmm0
               	movl	$0x41400000, %eax       # imm = 0x41400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x400f5c28f5c28f5c, %rax # imm = 0x400F5C28F5C28F5C
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	ja	<addr>
               	leaq	<rip>, %rax
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x400f70a3d70a3d71, %rax # imm = 0x400F70A3D70A3D71
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$0x3fe8000000000000, %rax # imm = 0x3FE8000000000000
               	movq	%rax, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
