
indirect_call_mixed_fp_int_args.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<mixfn>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	addq	%rdi, %rax
               	addq	%rsi, %rax
               	movabsq	$0x4059000000000000, %rcx # imm = 0x4059000000000000
               	movq	%rcx, %xmm15
               	movapd	%xmm1, %xmm0
               	mulsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rcx
               	addq	%rcx, %rax
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movq	%rcx, %xmm15
               	movapd	%xmm2, %xmm0
               	mulss	%xmm15, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	cvttsd2si	%xmm0, %rcx
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-<rip>, %rax       # <addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rbx
               	leaq	<rip>, %rcx
               	movsd	(%rcx,%riz), %xmm14
               	movsd	%xmm14, 0x18(%rsp)
               	leaq	0x2(%rbx), %rcx
               	movslq	%ecx, %rsi
               	movabsq	$0x3fd0000000000000, %rdx # imm = 0x3FD0000000000000
               	movl	$0x3fc00000, %ecx       # imm = 0x3FC00000
               	movl	$0x7, %r8d
               	movsd	0x18(%rsp), %xmm0
               	movq	%rdx, %xmm1
               	movq	%rcx, %xmm2
               	movq	%rbx, %rdi
               	movq	%r8, %rdx
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x40, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	0x2(%rbx), %rdx
               	movabsq	$0x3fd0000000000000, %rdi # imm = 0x3FD0000000000000
               	movl	$0x3fc00000, %r8d       # imm = 0x3FC00000
               	movl	$0x7, %r9d
               	movabsq	$0x4024000000000000, %rcx # imm = 0x4024000000000000
               	movq	%rcx, %xmm15
               	movsd	0x18(%rsp), %xmm0
               	mulsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rcx
               	addq	%rbx, %rcx
               	addq	%rdx, %rcx
               	movabsq	$0x4059000000000000, %rdx # imm = 0x4059000000000000
               	movq	%rdx, %xmm15
               	movq	%rdi, %xmm0
               	mulsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rdx
               	addq	%rdx, %rcx
               	movl	$0x40000000, %edx       # imm = 0x40000000
               	movq	%rdx, %xmm15
               	movq	%r8, %xmm0
               	mulss	%xmm15, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	cvttsd2si	%xmm0, %rdx
               	addq	%rdx, %rcx
               	addq	%r9, %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
