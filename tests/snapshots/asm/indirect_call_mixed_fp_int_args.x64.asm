
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
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rax
               	leaq	<rip>, %rcx      # <addr>
               	movsd	(%rcx), %xmm0
               	leaq	0x2(%rax), %rcx
               	movabsq	$0x3fd0000000000000, %rdx # imm = 0x3FD0000000000000
               	movl	$0x3fc00000, %esi       # imm = 0x3FC00000
               	movabsq	$0x4024000000000000, %rdi # imm = 0x4024000000000000
               	movq	%rdi, %xmm15
               	vmulsd	%xmm15, %xmm0, %xmm1
               	cvttsd2si	%xmm1, %rdi
               	addq	%rax, %rdi
               	addq	%rcx, %rdi
               	movabsq	$0x4059000000000000, %r8 # imm = 0x4059000000000000
               	movq	%rdx, %xmm14
               	movq	%r8, %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm1
               	cvttsd2si	%xmm1, %r8
               	addq	%r8, %rdi
               	movl	$0x40000000, %r8d       # imm = 0x40000000
               	movq	%rsi, %xmm14
               	movq	%r8, %xmm15
               	vmulss	%xmm15, %xmm14, %xmm1
               	cvttss2si	%xmm1, %rsi
               	addq	%rsi, %rdi
               	addq	$0x7, %rdi
               	cmpl	$0x40, %edi
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movabsq	$0x4024000000000000, %r8 # imm = 0x4024000000000000
               	movq	%r8, %xmm15
               	mulsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %r8
               	addq	%r8, %rax
               	addq	%rcx, %rax
               	movabsq	$0x4059000000000000, %rcx # imm = 0x4059000000000000
               	movq	%rdx, %xmm14
               	movq	%rcx, %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm0
               	cvttsd2si	%xmm0, %rcx
               	addq	%rcx, %rax
               	addq	%rsi, %rax
               	addq	$0x7, %rax
               	cmpl	%eax, %edi
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%eax, %eax
               	retq
