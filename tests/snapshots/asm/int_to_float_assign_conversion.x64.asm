
int_to_float_assign_conversion.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x8(%rbp), %rcx
               	movl	$0xa, %eax
               	movb	%al, (%rcx)
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x64, %edx
               	movb	%dl, 0x1(%rcx)
               	leaq	-0x8(%rbp), %rcx
               	movl	$0xc8, %edx
               	movb	%dl, 0x2(%rcx)
               	leaq	-0x8(%rbp), %rcx
               	movzbq	(%rcx), %rcx
               	cvtsi2sd	%rcx, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	leaq	-0x8(%rbp), %rcx
               	movzbq	0x1(%rcx), %rcx
               	cvtsi2sd	%rcx, %xmm1
               	cvtsd2ss	%xmm1, %xmm2
               	leaq	-0x8(%rbp), %rcx
               	movzbq	0x2(%rcx), %rcx
               	cvtsi2sd	%rcx, %xmm1
               	cvtsd2ss	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm3
               	cvtsd2ss	%xmm3, %xmm3
               	movapd	%xmm3, %xmm15
               	movapd	%xmm0, %xmm3
               	mulss	%xmm15, %xmm3
               	cvtss2sd	%xmm3, %xmm3
               	cvttsd2si	%xmm3, %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	cvtsi2sd	%rax, %xmm3
               	cvtsd2ss	%xmm3, %xmm3
               	movapd	%xmm3, %xmm15
               	movapd	%xmm2, %xmm3
               	mulss	%xmm15, %xmm3
               	cvtss2sd	%xmm3, %xmm3
               	cvttsd2si	%xmm3, %rax
               	cmpq	$0x3e8, %rax            # imm = 0x3E8
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	cvtsi2sd	%rax, %xmm3
               	cvtsd2ss	%xmm3, %xmm3
               	movapd	%xmm3, %xmm15
               	movapd	%xmm1, %xmm3
               	mulss	%xmm15, %xmm3
               	cvtss2sd	%xmm3, %xmm3
               	cvttsd2si	%xmm3, %rax
               	cmpq	$0x7d0, %rax            # imm = 0x7D0
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzbq	0x1(%rax), %rax
               	cvtsi2sd	%rax, %xmm3
               	cvtsd2ss	%xmm3, %xmm3
               	movl	$0x64, %eax
               	cvtsi2sd	%rax, %xmm4
               	cvtsd2ss	%xmm4, %xmm4
               	mulss	%xmm4, %xmm3
               	cvtss2sd	%xmm3, %xmm3
               	cvttsd2si	%xmm3, %rax
               	cmpq	$0x2710, %rax           # imm = 0x2710
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3e991687, %eax       # imm = 0x3E991687
               	movl	$0x3f1645a2, %ecx       # imm = 0x3F1645A2
               	movapd	%xmm2, %xmm15
               	movq	%rcx, %xmm2
               	mulss	%xmm15, %xmm2
               	movq	%rax, %xmm14
               	movapd	%xmm0, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movl	$0x3de978d5, %eax       # imm = 0x3DE978D5
               	movq	%rax, %xmm14
               	movapd	%xmm1, %xmm15
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movl	$0x43000000, %eax       # imm = 0x43000000
               	movq	%rax, %xmm15
               	subss	%xmm15, %xmm0
               	movl	$0x422c0000, %eax       # imm = 0x422C0000
               	movq	%rax, %xmm1
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomiss	%xmm1, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x42300000, %eax       # imm = 0x42300000
               	movq	%rax, %xmm1
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomiss	%xmm1, %xmm0
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	cvtsi2sd	%rax, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movl	$0x40e00000, %eax       # imm = 0x40E00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
