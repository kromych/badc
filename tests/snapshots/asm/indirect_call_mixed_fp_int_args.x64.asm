
indirect_call_mixed_fp_int_args.x64:	file format elf64-x86-64

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
               	movslq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movsd	(%rcx,%riz), %xmm0
               	leaq	0x2(%rax), %rcx
               	movabsq	$0x3fd0000000000000, %rdi # imm = 0x3FD0000000000000
               	movl	$0x3fc00000, %r8d       # imm = 0x3FC00000
               	movabsq	$0x4024000000000000, %rdx # imm = 0x4024000000000000
               	movq	%rdx, %xmm15
               	movapd	%xmm0, %xmm1
               	mulsd	%xmm15, %xmm1
               	cvttsd2si	%xmm1, %rdx
               	addq	%rax, %rdx
               	addq	%rdx, %rcx
               	movabsq	$0x4059000000000000, %rdx # imm = 0x4059000000000000
               	movq	%rdx, %xmm15
               	movq	%rdi, %xmm1
               	mulsd	%xmm15, %xmm1
               	cvttsd2si	%xmm1, %rdx
               	addq	%rdx, %rcx
               	movl	$0x40000000, %edx       # imm = 0x40000000
               	movq	%rdx, %xmm15
               	movq	%r8, %xmm1
               	mulss	%xmm15, %xmm1
               	cvttss2si	%xmm1, %rdx
               	addq	%rdx, %rcx
               	addq	$0x7, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0x40, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	0x2(%rax), %rdx
               	movabsq	$0x3fd0000000000000, %r8 # imm = 0x3FD0000000000000
               	movl	$0x3fc00000, %r9d       # imm = 0x3FC00000
               	movabsq	$0x4024000000000000, %rsi # imm = 0x4024000000000000
               	movq	%rsi, %xmm15
               	mulsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rsi
               	addq	%rsi, %rax
               	addq	%rdx, %rax
               	movabsq	$0x4059000000000000, %rdx # imm = 0x4059000000000000
               	movq	%rdx, %xmm15
               	movq	%r8, %xmm0
               	mulsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rdx
               	addq	%rdx, %rax
               	movl	$0x40000000, %edx       # imm = 0x40000000
               	movq	%rdx, %xmm15
               	movq	%r9, %xmm0
               	mulss	%xmm15, %xmm0
               	cvttss2si	%xmm0, %rdx
               	addq	%rdx, %rax
               	addq	$0x7, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorq	%rax, %rax
               	retq
