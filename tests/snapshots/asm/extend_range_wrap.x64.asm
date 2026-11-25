
extend_range_wrap.x64:	file format elf64-x86-64

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

<count_down>:
               	movslq	%esi, %rsi
               	xorl	%eax, %eax
               	testl	%esi, %esi
               	jl	<addr>
               	movslq	(%rdi,%rsi,4), %rcx
               	addq	%rcx, %rax
               	decq	%rsi
               	testl	%esi, %esi
               	jge	<addr>
               	retq

<guard_then_join>:
               	movl	$0x7, %eax
               	retq

<guarded>:
               	movslq	%edi, %rdi
               	xorl	%eax, %eax
               	leaq	0x1(%rdi), %rcx
               	cmpl	$0x64, %edi
               	cmovlq	%rcx, %rax
               	retq

<uwrap>:
               	xorl	%eax, %eax
               	cmpl	$0x2, %edi
               	je	<addr>
               	movl	%edi, %ecx
               	addq	%rcx, %rax
               	incq	%rdi
               	cmpl	$0x2, %edi
               	jne	<addr>
               	retq

<as_ulong>:
               	leaq	0x2(%rdi), %rax
               	movl	%eax, %eax
               	retq

<shr4>:
               	leaq	0x2(%rdi), %rax
               	movl	%eax, %eax
               	shrq	$0x4, %rax
               	retq

<div3>:
               	leaq	0x2(%rdi), %rax
               	movl	%eax, %eax
               	movl	$0xaaaaaaab, %r11d      # imm = 0xAAAAAAAB
               	imulq	%r11, %rax
               	shrq	$0x21, %rax
               	retq

<divv>:
               	leaq	0x2(%rdi), %rax
               	movl	%eax, %eax
               	movl	$0xaaaaaaab, %r11d      # imm = 0xAAAAAAAB
               	imulq	%r11, %rax
               	shrq	$0x21, %rax
               	retq

<modv>:
               	leaq	0x8(%rdi), %rax
               	movl	%eax, %eax
               	movl	$0xcccccccd, %ecx       # imm = 0xCCCCCCCD
               	imulq	%rax, %rcx
               	shrq	$0x22, %rcx
               	leaq	(%rcx,%rcx,4), %rcx
               	subq	%rcx, %rax
               	retq

<less64>:
               	leaq	0x2(%rdi), %rax
               	movl	%eax, %eax
               	cmpq	$0x2, %rax
               	setl	%al
               	movzbq	%al, %rax
               	retq

<store8>:
               	leaq	0x2(%rdi), %rax
               	movl	%eax, %eax
               	movq	%rax, (%rdx)
               	retq

<pass>:
               	movq	%rdi, %rax
               	retq

<as_arg>:
               	leaq	0x2(%rdi), %rax
               	movl	%eax, %edi
               	jmp	<addr>

<index_of>:
               	leaq	0x2(%rsi), %rax
               	movl	%eax, %eax
               	movq	(%rdi,%rax,8), %rax
               	retq

<as_double>:
               	leaq	0x2(%rdi), %rax
               	movl	%eax, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	retq

<usum_nonzero>:
               	leaq	(%rdi,%rsi), %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<diff_zero>:
               	subq	%rsi, %rdi
               	movl	$0x7, %eax
               	movl	$0x9, %ecx
               	testl	%edi, %edi
               	cmovneq	%rcx, %rax
               	retq

<main>:
               	subq	$0x38, %rsp
               	movl	$0x7fffffff, 0x10(%rsp) # imm = 0x7FFFFFFF
               	movl	$0x80000000, 0x18(%rsp) # imm = 0x80000000
               	movl	$0xffffffff, 0x20(%rsp) # imm = 0xFFFFFFFF
               	movl	$0x80000000, 0x28(%rsp) # imm = 0x80000000
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x10e1, %rax           # imm = 0x10E1
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movq	$-0x1, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	$0x63, %edi
               	callq	<addr>
               	cmpq	$0x64, %rax
               	jne	<addr>
               	movl	0x18(%rsp), %edi
               	callq	<addr>
               	cmpq	$-0x7fffffff, %rax      # imm = 0x80000001
               	jne	<addr>
               	movl	0x10(%rsp), %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	0x20(%rsp), %eax
               	leaq	-0x1(%rax), %rdi
               	callq	<addr>
               	movabsq	$0x1fffffffe, %r11      # imm = 0x1FFFFFFFE
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	0x20(%rsp), %edi
               	movl	$0x2, %esi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	0x20(%rsp), %edi
               	movl	$0x2, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	0x20(%rsp), %edi
               	movl	$0x2, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	0x20(%rsp), %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	0x20(%rsp), %edi
               	movl	$0x8, %esi
               	movl	$0x5, %edx
               	callq	<addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	0x20(%rsp), %edi
               	movl	$0x2, %esi
               	movl	$0x2, %edx
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	$-0x1, 0x8(%rsp)
               	movl	0x20(%rsp), %edi
               	movl	$0x2, %esi
               	leaq	0x8(%rsp), %rdx
               	callq	<addr>
               	movq	0x8(%rsp), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	0x20(%rsp), %edi
               	movl	$0x2, %esi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	0x20(%rsp), %esi
               	movl	$0x2, %edx
               	callq	<addr>
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	0x20(%rsp), %edi
               	movl	$0x2, %esi
               	callq	<addr>
               	ucomisd	<rip>, %xmm0 # <addr>
               	jp	<addr>
               	je	<addr>
               	movl	$0x1a, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	0x28(%rsp), %edi
               	movl	0x28(%rsp), %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1d, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	0x28(%rsp), %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1e, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	0x18(%rsp), %edi
               	movl	0x18(%rsp), %esi
               	callq	<addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	0x18(%rsp), %edi
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x1f, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq
