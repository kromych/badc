
sroa_copies_between_objects.x64:	file format elf64-x86-64

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

<swap_loop>:
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rax # <addr>
               	leaq	(%rax,%rax,2), %rcx
               	xorl	%eax, %eax
               	cmpq	%rdi, %rax
               	jge	<addr>
               	addq	%rax, %rdx
               	incq	%rax
               	xchgq	%rdx, %rcx
               	cmpq	%rdi, %rax
               	jl	<addr>
               	movq	%rdx, %rax
               	subq	%rcx, %rax
               	retq

<rotate>:
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	<rip>, %rsi # <addr>
               	movl	$0x1, %r8d
               	movl	$0x2, %edx
               	movq	<rip>, %rdi # <addr>
               	movl	$0x3, %r9d
               	movl	$0x4, %ecx
               	xorl	%eax, %eax
               	cmpq	%rbx, %rax
               	jge	<addr>
               	addq	%rax, %rsi
               	incq	%rax
               	xchgq	%rsi, %r9
               	xchgq	%r8, %rcx
               	xchgq	%rsi, %rdx
               	xchgq	%r8, %rdi
               	cmpq	%rbx, %rax
               	jl	<addr>
               	imulq	$0xf4240, %rsi, %rax    # imm = 0xF4240
               	imulq	$0x2710, %r8, %rsi      # imm = 0x2710
               	addq	%rsi, %rax
               	imulq	$0x64, %rdx, %rdx
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	retq

<member_copy>:
               	pushq	%rbx
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rdx
               	movq	<rip>, %rax # <addr>
               	leaq	0x2(%rax), %r8
               	xorl	%eax, %eax
               	movq	%rax, %r9
               	movq	%rax, %rsi
               	cmpq	%rdi, %rsi
               	jge	<addr>
               	addq	%rdx, %rcx
               	incq	%rsi
               	xchgq	%rdx, %rax
               	xchgq	%r8, %r9
               	nopw	(%rax,%rax)
               	cmpq	%rdi, %rsi
               	jl	<addr>
               	leaq	(%rcx,%r8), %rax
               	subq	%r9, %rax
               	popq	%rbx
               	retq

<two_widths>:
               	movq	<rip>, %rax # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$-0x100000000, %rdx     # imm = 0xFFFFFFFF00000000
               	cmpq	%rdi, %rcx
               	jge	<addr>
               	movq	%rax, %rsi
               	shrq	$0x20, %rsi
               	addq	%rcx, %rsi
               	movq	%rax, %r8
               	andq	%rdx, %r8
               	orq	%r8, %rsi
               	movl	%esi, %esi
               	shlq	$0x20, %rax
               	orq	%rsi, %rax
               	incq	%rcx
               	nopw	(%rax,%rax)
               	cmpq	%rdi, %rcx
               	jl	<addr>
               	retq

<fp_swap>:
               	movq	<rip>, %rax # <addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movq	%xmm0, %rdx
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	xorl	%eax, %eax
               	cmpq	%rdi, %rax
               	jge	<addr>
               	movq	%rdx, %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	movq	%xmm0, %rdx
               	incq	%rax
               	xchgq	%rdx, %rcx
               	nopl	(%rax)
               	cmpq	%rdi, %rax
               	jl	<addr>
               	movq	%rdx, %xmm0
               	movq	%rcx, %xmm1
               	subsd	%xmm1, %xmm0
               	retq

<main>:
               	pushq	%rax
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpq	$0x2f7665, %rax         # imm = 0x2F7665
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	movabsq	$0xc00000002, %r11      # imm = 0xC00000002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
