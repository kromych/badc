
fp_sign_bit_operations.x64:	file format elf64-x86-64

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

<bitsf>:
               	subq	$0x18, %rsp
               	movss	%xmm0, 0x8(%rsp)
               	movl	0x8(%rsp), %eax
               	addq	$0x18, %rsp
               	retq

<off>:
               	subq	$0x18, %rsp
               	movl	%edi, 0x8(%rsp)
               	movss	0x8(%rsp), %xmm0
               	addq	$0x18, %rsp
               	retq

<absd>:
               	vandpd	<rip>, %xmm0, %xmm0 # <addr>
               	retq

<negd>:
               	vxorpd	<rip>, %xmm0, %xmm0 # <addr>
               	retq

<nabsd>:
               	vandpd	<rip>, %xmm0, %xmm0 # <addr>
               	vxorpd	<rip>, %xmm0, %xmm0 # <addr>
               	retq

<absf>:
               	vandpd	<rip>, %xmm0, %xmm0 # <addr>
               	retq

<negf>:
               	vxorpd	<rip>, %xmm0, %xmm0 # <addr>
               	retq

<sum_abs>:
               	xorl	%eax, %eax
               	xorps	%xmm0, %xmm0
               	cmpl	%esi, %eax
               	jge	<addr>
               	vmovq	(%rdi,%rax,8), %xmm1
               	vandpd	<rip>, %xmm1, %xmm1 # <addr>
               	vmovq	(%rdi,%rax,8), %xmm2
               	vxorpd	<rip>, %xmm2, %xmm2 # <addr>
               	subsd	%xmm2, %xmm1
               	addsd	%xmm1, %xmm0
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	retq

<main>:
               	subq	$0x218, %rsp            # imm = 0x218
               	pushq	%r12
               	pushq	%rbx
               	movabsq	$-0x8000000000000000, %r12 # imm = 0x8000000000000000
               	xorl	%ebx, %ebx
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %rax
               	movq	%rax, %xmm0
               	callq	<addr>
               	movq	%xmm0, %rcx
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %rax
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rax, %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	%rax, %xmm0
               	callq	<addr>
               	movq	%xmm0, %rcx
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %rax
               	movq	%rax, %rdx
               	xorq	%r12, %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	%rax, %xmm0
               	callq	<addr>
               	movq	%xmm0, %rcx
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %rax
               	orq	%r12, %rax
               	nopw	(%rax,%rax)
               	cmpq	%rax, %rcx
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0xa, %ebx
               	jb	<addr>
               	xorl	%ebx, %ebx
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%rbx,4), %edi
               	callq	<addr>
               	callq	<addr>
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx,%rbx,4), %edi
               	movq	%rdi, %rcx
               	andq	$0x7fffffff, %rcx       # imm = 0x7FFFFFFF
               	cmpl	%ecx, %eax
               	jne	<addr>
               	callq	<addr>
               	callq	<addr>
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx,%rbx,4), %ecx
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	xorq	%r11, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	incq	%rbx
               	nopl	(%rax)
               	cmpl	$0x8, %ebx
               	jb	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x20(%rsp,%rax,8)
               	incq	%rax
               	nop
               	cmpl	$0x40, %eax
               	jge	<addr>
               	leaq	0x20(%rsp), %rcx
               	testb	$0x1, %al
               	je	<addr>
               	movabsq	$-0x4020000000000000, %r11 # imm = 0xBFE0000000000000
               	movq	%r11, %xmm0
               	nopl	(%rax)
               	jmp	<addr>
               	movabsq	$0x3fd0000000000000, %r11 # imm = 0x3FD0000000000000
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	xorps	%xmm1, %xmm1
               	jmp	<addr>
               	xorps	%xmm3, %xmm3
               	cvtsi2sd	%rax, %xmm3
               	vfmadd231sd	%xmm3, %xmm2, %xmm0 # xmm0 = (xmm2 * xmm3) + xmm0
               	addsd	%xmm0, %xmm1
               	incq	%rax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	nopw	(%rax,%rax)
               	testq	%rcx, %rcx
               	je	<addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	vmulsd	<rip>, %xmm0, %xmm0 # <addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movabsq	$-0x4020000000000000, %r11 # imm = 0xBFE0000000000000
               	movq	%r11, %xmm2
               	jmp	<addr>
               	movabsq	$0x3fd0000000000000, %r11 # imm = 0x3FD0000000000000
               	movq	%r11, %xmm2
               	jmp	<addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	vmulsd	<rip>, %xmm0, %xmm0 # <addr>
               	jmp	<addr>
               	movsd	%xmm1, 0x18(%rsp)
               	leaq	0x20(%rsp), %rdi
               	movl	$0x40, %esi
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x218, %rsp            # imm = 0x218
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x218, %rsp            # imm = 0x218
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x218, %rsp            # imm = 0x218
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x218, %rsp            # imm = 0x218
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x218, %rsp            # imm = 0x218
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x218, %rsp            # imm = 0x218
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x218, %rsp            # imm = 0x218
               	retq
