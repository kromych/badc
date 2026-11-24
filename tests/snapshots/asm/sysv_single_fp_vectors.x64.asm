
sysv_single_fp_vectors.x64:	file format elf64-x86-64

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

<take_f1>:
               	subq	$0x18, %rsp
               	movl	0x20(%rsp), %r10d
               	movl	%r10d, 0x8(%rsp)
               	movss	0x8(%rsp), %xmm1
               	vmulss	<rip>, %xmm1, %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	vfmadd132sd	<rip>, %xmm1, %xmm0 # xmm0 = (xmm0 * mem) + xmm1
               	cvttsd2si	%xmm0, %rax
               	addq	%rdi, %rax
               	addq	$0x18, %rsp
               	retq

<take_d1>:
               	subq	$0x18, %rsp
               	movq	0x20(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movsd	0x8(%rsp), %xmm1
               	vmulsd	<rip>, %xmm0, %xmm0
               	vfmadd231sd	<rip>, %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
               	cvttsd2si	%xmm0, %rax
               	addq	%rdi, %rax
               	addq	$0x18, %rsp
               	retq

<take_ff>:
               	subq	$0x18, %rsp
               	movq	0x20(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movss	0x8(%rsp), %xmm1
               	movss	0xc(%rsp), %xmm2
               	vmulss	<rip>, %xmm2, %xmm2
               	vfmadd132ss	<rip>, %xmm2, %xmm1 # xmm1 = (xmm1 * mem) + xmm2
               	cvtss2sd	%xmm1, %xmm1
               	vfmadd132sd	<rip>, %xmm1, %xmm0 # xmm0 = (xmm0 * mem) + xmm1
               	cvttsd2si	%xmm0, %rax
               	addq	%rdi, %rax
               	addq	$0x18, %rsp
               	retq

<make_f1>:
               	subq	$0x38, %rsp
               	movq	%rdi, (%rsp)
               	leaq	0x28(%rsp), %rcx
               	movss	%xmm0, 0x28(%rsp)
               	movq	(%rsp), %rax
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	addq	$0x38, %rsp
               	retq

<make_d1>:
               	subq	$0x28, %rsp
               	movq	%rdi, (%rsp)
               	movq	(%rsp), %rax
               	movsd	%xmm0, (%rax)
               	addq	$0x28, %rsp
               	retq

<peek_f1>:
               	xorl	%eax, %eax
               	cmpl	$0x3fc00000, 0x8(%rsp)  # imm = 0x3FC00000
               	jne	<addr>
               	orl	$0x1, %eax
               	movq	%xmm0, %rcx
               	movabsq	$0x4004000000000000, %rdx # imm = 0x4004000000000000
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	orl	$0x2, %eax
               	cmpq	$0x7, %rdi
               	jne	<addr>
               	orl	$0x4, %eax
               	retq

<peek_d1>:
               	xorl	%eax, %eax
               	movabsq	$0x3ff8000000000000, %rdx # imm = 0x3FF8000000000000
               	cmpq	%rdx, 0x8(%rsp)
               	jne	<addr>
               	orl	$0x1, %eax
               	movq	%xmm0, %rcx
               	movabsq	$0x4004000000000000, %rdx # imm = 0x4004000000000000
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	orl	$0x2, %eax
               	cmpq	$0x7, %rdi
               	jne	<addr>
               	orl	$0x4, %eax
               	retq

<peek_ff>:
               	xorl	%eax, %eax
               	movabsq	$0x404000003fc00000, %rdx # imm = 0x404000003FC00000
               	cmpq	%rdx, 0x8(%rsp)
               	jne	<addr>
               	orl	$0x1, %eax
               	movq	%xmm0, %rcx
               	movabsq	$0x4004000000000000, %rdx # imm = 0x4004000000000000
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	orl	$0x2, %eax
               	cmpq	$0x7, %rdi
               	jne	<addr>
               	orl	$0x4, %eax
               	retq

<give_f1>:
               	movl	$0x3fc00000, (%rdi)     # imm = 0x3FC00000
               	movq	%rdi, %rax
               	retq

<give_d1>:
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, (%rdi)
               	movq	%rdi, %rax
               	retq

<via_take_f1>:
               	movq	%rdi, %r11
               	subq	$0x18, %rsp
               	movl	$0x3fc00000, (%rsp)     # imm = 0x3FC00000
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm0
               	movq	$0x7, %rdi
               	movq	$-0x1, %rsi
               	movq	%rsi, %xmm1
               	callq	*%r11
               	addq	$0x18, %rsp
               	retq

<via_take_d1>:
               	movq	%rdi, %r11
               	subq	$0x18, %rsp
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, (%rsp)
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm0
               	movq	$0x7, %rdi
               	movq	$-0x1, %rsi
               	movq	%rsi, %xmm1
               	callq	*%r11
               	addq	$0x18, %rsp
               	retq

<via_take_ff>:
               	movq	%rdi, %r11
               	subq	$0x18, %rsp
               	movabsq	$0x404000003fc00000, %rax # imm = 0x404000003FC00000
               	movq	%rax, (%rsp)
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm0
               	movq	$0x7, %rdi
               	movq	$-0x1, %rsi
               	movq	%rsi, %xmm1
               	callq	*%r11
               	addq	$0x18, %rsp
               	retq

<via_make_f1>:
               	movq	%rdi, %r11
               	subq	$0x18, %rsp
               	movq	$-0x1, 0x8(%rsp)
               	leaq	0x8(%rsp), %rdi
               	movl	$0x3fc00000, %eax       # imm = 0x3FC00000
               	movd	%eax, %xmm0
               	callq	*%r11
               	leaq	0x8(%rsp), %rcx
               	cmpq	%rcx, %rax
               	movl	0x8(%rsp), %eax
               	je	<addr>
               	movq	$-0x2, %rax
               	addq	$0x18, %rsp
               	retq

<via_make_d1>:
               	movq	%rdi, %r11
               	subq	$0x18, %rsp
               	movq	$-0x1, 0x8(%rsp)
               	leaq	0x8(%rsp), %rdi
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm0
               	callq	*%r11
               	leaq	0x8(%rsp), %rcx
               	cmpq	%rcx, %rax
               	movq	0x8(%rsp), %rax
               	je	<addr>
               	movq	$-0x2, %rax
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x28, %rsp
               	subq	$0x10, %rsp
               	leaq	0x18(%rsp), %r9
               	leaq	<rip>, %rax
               	movl	(%rax), %r10d
               	movl	%r10d, (%r9)
               	leaq	0x20(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	0x28(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	<rip>, %xmm0
               	movl	$0x7, %edi
               	movq	%r9, %r10
               	movzbq	(%r10), %r11
               	movb	%r11b, (%rsp)
               	movzbq	0x1(%r10), %r11
               	movb	%r11b, 0x1(%rsp)
               	movzbq	0x2(%r10), %r11
               	movb	%r11b, 0x2(%rsp)
               	movzbq	0x3(%r10), %r11
               	movb	%r11b, 0x3(%rsp)
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	addq	$0x28, %rsp
               	retq
               	leaq	0x20(%rsp), %r9
               	movsd	<rip>, %xmm0
               	movl	$0x7, %edi
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	addq	$0x28, %rsp
               	retq
               	leaq	0x28(%rsp), %r9
               	movsd	<rip>, %xmm0
               	movl	$0x7, %edi
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x10, %rsp
               	addq	$0x28, %rsp
               	retq
               	leaq	0x28(%rsp), %rdi
               	callq	<addr>
               	leaq	0x28(%rsp), %rdi
               	movss	0x28(%rsp), %xmm0
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x10, %rsp
               	addq	$0x28, %rsp
               	retq
               	callq	<addr>
               	movsd	0x28(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x10, %rsp
               	addq	$0x28, %rsp
               	retq
               	leaq	-<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpq	$0xb6, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x10, %rsp
               	addq	$0x28, %rsp
               	retq
               	leaq	-<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpq	$0xb6, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x10, %rsp
               	addq	$0x28, %rsp
               	retq
               	leaq	-<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpq	$0xc6e, %rax            # imm = 0xC6E
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x10, %rsp
               	addq	$0x28, %rsp
               	retq
               	leaq	-<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpq	$0x3fc00000, %rax       # imm = 0x3FC00000
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x10, %rsp
               	addq	$0x28, %rsp
               	retq
               	leaq	-<rip>, %rdi # <addr>
               	callq	<addr>
               	movabsq	$0x3ff8000000000000, %r11 # imm = 0x3FF8000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x10, %rsp
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x10, %rsp
               	addq	$0x28, %rsp
               	retq
