
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
               	movapd	%xmm0, %xmm1
               	addsd	%xmm1, %xmm0
               	retq

<twicef>:
               	movapd	%xmm0, %xmm1
               	addss	%xmm1, %xmm0
               	retq

<sub_second>:
               	movapd	%xmm0, %xmm3
               	movapd	%xmm2, %xmm0
               	subsd	%xmm1, %xmm0
               	xorps	%xmm1, %xmm1
               	vfmadd231sd	%xmm1, %xmm3, %xmm0 # xmm0 = (xmm3 * xmm1) + xmm0
               	retq

<root>:
               	movapd	%xmm0, %xmm1
               	sqrtsd	%xmm1, %xmm0
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
               	addsd	%xmm0, %xmm0
               	retq

<vadd>:
               	addps	%xmm1, %xmm0
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
               	movups	%xmm0, 0x30(%rsp)
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%bl
               	movzbq	%bl, %rbx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rbx
               	movss	<rip>, %xmm0
               	callq	<addr>
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	addq	%rax, %rbx
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	movsd	<rip>, %xmm2
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	addq	%rax, %rbx
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	addq	%rax, %rbx
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%rax, %rbx
               	leaq	-0x10(%rbp), %rdi
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	-0x10(%rbp), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	movl	$0x1, %eax
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x8(%rbp), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	addq	%rax, %rbx
               	leaq	-0x18(%rbp), %rdi
               	movss	<rip>, %xmm0
               	callq	<addr>
               	movss	-0x18(%rbp), %xmm0
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	movl	$0x1, %eax
               	jp	<addr>
               	jne	<addr>
               	movss	-0x14(%rbp), %xmm0
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	addq	%rax, %rbx
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	leaq	(%rbx,%rax), %rcx
               	movups	0x30(%rsp), %xmm0
               	vpermilps	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0,0,0]
               	movss	<rip>, %xmm2
               	ucomiss	%xmm2, %xmm1
               	movl	$0x1, %eax
               	jp	<addr>
               	jne	<addr>
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	addq	%rcx, %rax
               	movl	$0x2a, %ecx
               	testl	%eax, %eax
               	cmoveq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq
