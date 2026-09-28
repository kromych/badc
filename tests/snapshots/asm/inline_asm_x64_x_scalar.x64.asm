
inline_asm_x64_x_scalar.x64:	file format elf64-x86-64

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

<twice>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movapd	%xmm0, %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	leave
               	retq

<twicef>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movapd	%xmm0, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm0
               	leave
               	retq

<sub_second>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movapd	%xmm0, %xmm3
               	movapd	%xmm2, %xmm0
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	xorl	%eax, %eax
               	movapd	%xmm3, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	leave
               	retq

<root>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movapd	%xmm0, %xmm1
               	sqrtsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	leave
               	retq

<to_int>:
               	cvtsd2si	%xmm0, %rax
               	retq

<set_first>:
               	movapd	%xmm0, %xmm1
               	movsd	%xmm1, %xmm0            # xmm0 = xmm1[0],xmm0[1]
               	movsd	%xmm0, (%rdi)
               	retq

<set_firstf>:
               	movapd	%xmm0, %xmm1
               	movss	%xmm1, %xmm0            # xmm0 = xmm1[0],xmm0[1,2,3]
               	movss	%xmm0, (%rdi)
               	retq

<doubled>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	addsd	%xmm0, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	leave
               	retq

<vadd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movups	%xmm0, -0x20(%rbp)
               	movups	%xmm1, -0x10(%rbp)
               	movups	-0x20(%rbp), %xmm0
               	movups	-0x10(%rbp), %xmm1
               	addps	%xmm1, %xmm0
               	movups	%xmm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%rbx
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x50(%rbp), %r9
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movups	%xmm0, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%bl
               	movzbq	%bl, %rbx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rbx
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movl	$0x40a00000, %eax       # imm = 0x40A00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	addq	%rax, %rbx
               	movabsq	$0x401c000000000000, %rax # imm = 0x401C000000000000
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movabsq	$0x4023000000000000, %rdx # imm = 0x4023000000000000
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	movq	%rdx, %xmm2
               	callq	<addr>
               	movabsq	$0x401e000000000000, %rax # imm = 0x401E000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	addq	%rax, %rbx
               	movabsq	$0x4019000000000000, %rax # imm = 0x4019000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	addq	%rax, %rbx
               	movabsq	$-0x3ff8000000000000, %rax # imm = 0xC008000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%rax, %rbx
               	leaq	-0x10(%rbp), %rdi
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movsd	(%rcx), %xmm0
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	movl	$0x1, %eax
               	jp	<addr>
               	jne	<addr>
               	movsd	0x8(%rcx), %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	addq	%rax, %rbx
               	leaq	-0x18(%rbp), %rdi
               	movl	$0x41000000, %eax       # imm = 0x41000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movss	(%rcx), %xmm0
               	movl	$0x41000000, %eax       # imm = 0x41000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	movl	$0x1, %eax
               	jp	<addr>
               	jne	<addr>
               	movss	0x4(%rcx), %xmm0
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	addq	%rax, %rbx
               	movabsq	$0x3fe8000000000000, %rax # imm = 0x3FE8000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	leaq	(%rbx,%rax), %rdx
               	leaq	-0x40(%rbp), %rcx
               	movss	(%rcx), %xmm0
               	movl	$0x41300000, %eax       # imm = 0x41300000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	movl	$0x1, %eax
               	jp	<addr>
               	jne	<addr>
               	movss	0xc(%rcx), %xmm0
               	movl	$0x42300000, %eax       # imm = 0x42300000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	addq	%rdx, %rax
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	jmp	<addr>
