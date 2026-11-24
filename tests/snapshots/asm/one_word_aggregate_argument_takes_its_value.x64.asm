
one_word_aggregate_argument_takes_its_value.x64:	file format elf64-x86-64

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

<regs>:
               	leaq	(%rdi,%rdi,2), %rax
               	movapd	%xmm0, %xmm14
               	movabsq	$0x43e0000000000000, %r11 # imm = 0x43E0000000000000
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jae	<addr>
               	cvttsd2si	%xmm14, %rcx
               	jmp	<addr>
               	subsd	%xmm15, %xmm14
               	cvttsd2si	%xmm14, %rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	orq	%r11, %rcx
               	addq	%rcx, %rax
               	addq	%rsi, %rax
               	retq

<stacked>:
               	subq	$0x18, %rsp
               	movq	0x30(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x40(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rsp), %rax
               	addq	$0x15, %rax
               	movq	0x28(%rsp), %rcx
               	addq	%rcx, %rax
               	movslq	0x38(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	(%rsp), %rcx
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	%rcx, %rax
               	movapd	%xmm0, %xmm14
               	movabsq	$0x43e0000000000000, %r11 # imm = 0x43E0000000000000
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jae	<addr>
               	cvttsd2si	%xmm14, %rcx
               	jmp	<addr>
               	subsd	%xmm15, %xmm14
               	cvttsd2si	%xmm14, %rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	orq	%r11, %rcx
               	addq	%rcx, %rax
               	movq	0x8(%rsp), %rcx
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq

<reals>:
               	subq	$0x18, %rsp
               	movq	0x20(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x28(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	addsd	%xmm1, %xmm0
               	addsd	%xmm2, %xmm0
               	addsd	%xmm3, %xmm0
               	addsd	%xmm4, %xmm0
               	addsd	%xmm5, %xmm0
               	addsd	%xmm6, %xmm0
               	addsd	%xmm7, %xmm0
               	movsd	(%rsp), %xmm1
               	vfmadd231sd	<rip>, %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
               	movsd	0x8(%rsp), %xmm1
               	vfmadd231sd	<rip>, %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
               	xorps	%xmm1, %xmm1
               	movq	%rdi, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm1
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm1
               	addsd	%xmm1, %xmm1
               	addsd	%xmm1, %xmm0
               	addq	$0x18, %rsp
               	retq

<run>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	(%rdi), %r12
               	movq	0x8(%rdi), %rbx
               	movsd	(%rsi), %xmm0
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	%rax, %r13
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	subq	$0x30, %rsp
               	movq	$0x7, (%rsp)
               	movq	$0x8, 0x8(%rsp)
               	movq	%r12, 0x10(%rsp)
               	movq	$0x9, 0x18(%rsp)
               	movq	%rbx, 0x20(%rsp)
               	movsd	0x58(%rsp), %xmm0
               	callq	<addr>
               	addq	$0x30, %rsp
               	addq	%rax, %r13
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	movsd	<rip>, %xmm2
               	movsd	<rip>, %xmm3
               	movsd	<rip>, %xmm4
               	movsd	<rip>, %xmm5
               	movsd	<rip>, %xmm6
               	movsd	<rip>, %xmm7
               	subq	$0x10, %rsp
               	movq	0x38(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	$0x10, %rsp
               	movapd	%xmm0, %xmm14
               	movabsq	$0x43e0000000000000, %r11 # imm = 0x43E0000000000000
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jae	<addr>
               	cvttsd2si	%xmm14, %rax
               	jmp	<addr>
               	subsd	%xmm15, %xmm14
               	cvttsd2si	%xmm14, %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	orq	%r11, %rax
               	addq	%rax, %r13
               	movq	<rip>, %rax # <addr>
               	movsd	0x28(%rsp), %xmm0
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%rax
               	addq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	subq	$0x28, %rsp
               	leaq	0x10(%rsp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x8(%rsp), %rsi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rsi)
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	cmpq	$0x314, %rax            # imm = 0x314
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	addq	$0x28, %rsp
               	retq
