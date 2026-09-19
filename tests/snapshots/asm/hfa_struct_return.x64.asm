
hfa_struct_return.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movabsq	$0x401c000000000000, %rax # imm = 0x401C000000000000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$0x3fd0000000000000, %rax # imm = 0x3FD0000000000000
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rsi # imm = 0x4000000000000000
               	movabsq	$0x4008000000000000, %rdi # imm = 0x4008000000000000
               	movq	%rdx, %xmm14
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%rsi, %xmm14
               	movq	%rsi, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%rdi, %xmm14
               	movq	%rdi, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$0x4024000000000000, %rdx # imm = 0x4024000000000000
               	movabsq	$0x4034000000000000, %rsi # imm = 0x4034000000000000
               	movabsq	$0x403e000000000000, %rdi # imm = 0x403E000000000000
               	movabsq	$0x4044000000000000, %r8 # imm = 0x4044000000000000
               	movq	%rdx, %xmm14
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%rsi, %xmm14
               	movq	%rsi, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movabsq	$0x403e000000000000, %r9 # imm = 0x403E000000000000
               	movq	%rdi, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movabsq	$0x4044000000000000, %r9 # imm = 0x4044000000000000
               	movq	%r8, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3fc00000, %r9d       # imm = 0x3FC00000
               	movl	$0x40200000, %ebx       # imm = 0x40200000
               	movq	%r9, %xmm14
               	movq	%r9, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movl	$0x40200000, %r9d       # imm = 0x40200000
               	movq	%rbx, %xmm14
               	movq	%r9, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x10(%rbp), %r9
               	leaq	<rip>, %rbx
               	pushq	%rax
               	movq	(%rbx), %rax
               	movq	%rax, (%r9)
               	movq	0x8(%rbx), %rax
               	movq	%rax, 0x8(%r9)
               	popq	%rax
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	addsd	%xmm15, %xmm0
               	movabsq	$0x3fe8000000000000, %rax # imm = 0x3FE8000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rsi, %xmm15
               	movq	%rdx, %xmm0
               	addsd	%xmm15, %xmm0
               	movq	%rdi, %xmm15
               	addsd	%xmm15, %xmm0
               	movq	%r8, %xmm15
               	addsd	%xmm15, %xmm0
               	movabsq	$0x4059000000000000, %rax # imm = 0x4059000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	movss	(%rax,%riz), %xmm0
               	movss	0x4(%rax,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x8(%rax,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0xc(%rax,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movl	$0x41200000, %eax       # imm = 0x41200000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
