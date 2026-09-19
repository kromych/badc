
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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movsd	(%rcx,%riz), %xmm0
               	leaq	0x2(%rax), %rcx
               	movabsq	$0x3fd0000000000000, %rsi # imm = 0x3FD0000000000000
               	movl	$0x3fc00000, %edi       # imm = 0x3FC00000
               	movabsq	$0x4024000000000000, %rdx # imm = 0x4024000000000000
               	movq	%rdx, %xmm15
               	movapd	%xmm0, %xmm1
               	mulsd	%xmm15, %xmm1
               	cvttsd2si	%xmm1, %rdx
               	addq	%rax, %rdx
               	addq	%rcx, %rdx
               	movabsq	$0x4059000000000000, %r8 # imm = 0x4059000000000000
               	movq	%r8, %xmm15
               	movq	%rsi, %xmm1
               	mulsd	%xmm15, %xmm1
               	cvttsd2si	%xmm1, %r8
               	addq	%r8, %rdx
               	movl	$0x40000000, %r8d       # imm = 0x40000000
               	movq	%r8, %xmm15
               	movq	%rdi, %xmm1
               	mulss	%xmm15, %xmm1
               	cvttss2si	%xmm1, %r9
               	addq	%r9, %rdx
               	addq	$0x7, %rdx
               	cmpl	$0x40, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$0x4024000000000000, %rbx # imm = 0x4024000000000000
               	movq	%rbx, %xmm15
               	mulsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rbx
               	addq	%rbx, %rax
               	addq	%rcx, %rax
               	movabsq	$0x4059000000000000, %rcx # imm = 0x4059000000000000
               	movq	%rcx, %xmm15
               	movq	%rsi, %xmm0
               	mulsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rcx
               	addq	%rcx, %rax
               	addq	%r9, %rax
               	addq	$0x7, %rax
               	cmpl	%eax, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
