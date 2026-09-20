
init_scalar_conversion.x64:	file format elf64-x86-64

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

<rect_ok>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	movsd	(%rcx), %xmm0
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0x8(%rcx), %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	sete	%dl
               	movzbq	%dl, %rdx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsd	0x10(%rcx), %xmm0
               	movabsq	$0x408a400000000000, %rdx # imm = 0x408A400000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	sete	%dl
               	movzbq	%dl, %rdx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsd	0x18(%rcx), %xmm0
               	movabsq	$0x4080e00000000000, %rax # imm = 0x4080E00000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	leave
               	retq
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x348, %ebx            # imm = 0x348
               	movl	$0x21c, %r12d           # imm = 0x21C
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rbx, %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%r12, %xmm1
               	movabsq	$0x408a400000000000, %rax # imm = 0x408A400000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movabsq	$0x4080e00000000000, %rax # imm = 0x4080E00000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x20(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	$0x0, (%rax)
               	movq	$0x0, 0x8(%rax)
               	movsd	%xmm0, 0x10(%rax)
               	movsd	%xmm1, 0x18(%rax)
               	leaq	-0x20(%rbp), %r9
               	movsd	0x10(%r9), %xmm2
               	movabsq	$0x408a400000000000, %rax # imm = 0x408A400000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movsd	0x18(%r9), %xmm2
               	movabsq	$0x4080e00000000000, %rcx # imm = 0x4080E00000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movabsq	$0x400f333333333333, %rax # imm = 0x400F333333333333
               	movq	%rax, %xmm14
               	cvttsd2si	%xmm14, %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movl	$0x4078f5c3, %eax       # imm = 0x4078F5C3
               	movq	%rax, %xmm15
               	ucomiss	%xmm0, %xmm15
               	ja	<addr>
               	movl	$0x407a3d71, %eax       # imm = 0x407A3D71
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x20(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	$0x0, (%rax)
               	movq	$0x0, 0x8(%rax)
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rbx, %xmm0
               	movsd	%xmm0, 0x10(%rax)
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%r12, %xmm0
               	movsd	%xmm0, 0x18(%rax)
               	leaq	-0x20(%rbp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
