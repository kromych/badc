
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movsd	(%rcx,%riz), %xmm0
               	leaq	0x2(%rax), %rcx
               	movabsq	$0x3fd0000000000000, %rdi # imm = 0x3FD0000000000000
               	movl	$0x3fc00000, %ebx       # imm = 0x3FC00000
               	movabsq	$0x4024000000000000, %r8 # imm = 0x4024000000000000
               	movq	%r8, %xmm15
               	movapd	%xmm0, %xmm1
               	mulsd	%xmm15, %xmm1
               	cvttsd2si	%xmm1, %r9
               	leaq	(%rax,%r9), %rdx
               	leaq	(%rdx,%rcx), %rsi
               	movabsq	$0x4059000000000000, %r12 # imm = 0x4059000000000000
               	movq	%r12, %xmm15
               	movq	%rdi, %xmm2
               	mulsd	%xmm15, %xmm2
               	cvttsd2si	%xmm2, %r12
               	addq	%r12, %rsi
               	movl	$0x40000000, %r12d      # imm = 0x40000000
               	movq	%r12, %xmm15
               	movq	%rbx, %xmm2
               	mulss	%xmm15, %xmm2
               	cvttss2si	%xmm2, %rbx
               	addq	%rbx, %rsi
               	addq	$0x7, %rsi
               	cmpl	$0x40, %esi
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3fc00000, %r13d      # imm = 0x3FC00000
               	leaq	(%rdx,%rcx), %rax
               	movabsq	$0x4059000000000000, %rcx # imm = 0x4059000000000000
               	movq	%rcx, %xmm15
               	movq	%rdi, %xmm0
               	mulsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rcx
               	addq	%rcx, %rax
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movq	%rcx, %xmm15
               	movq	%r13, %xmm0
               	mulss	%xmm15, %xmm0
               	cvttss2si	%xmm0, %rcx
               	addq	%rcx, %rax
               	addq	$0x7, %rax
               	cmpl	%eax, %esi
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
