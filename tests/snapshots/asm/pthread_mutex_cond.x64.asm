
pthread_mutex_cond.x64:	file format elf64-x86-64

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

<try_lock>:
               	subq	$0x18, %rsp
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	%rcx, 0x8(%rsp)
               	callq	<addr>
               	movq	0x8(%rsp), %rcx
               	movslq	%ecx, %rax
               	addq	$0x18, %rsp
               	retq

<unlock>:
               	pushq	%rax
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%r11
               	retq

<consume>:
               	subq	$0x10, %rsp
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	incq	%rbx
               	cmpl	$0x3e8, %ebx            # imm = 0x3E8
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq

<wait_go>:
               	subq	$0x10, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rbx # <addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	%rbx, %rsi
               	callq	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq

<main>:
               	subq	$0xb8, %rsp
               	leaq	0x20(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x61, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x10(%rsp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x62, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	0x10(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x63, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x64, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x65, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x66, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	-<rip>, %rdx # <addr>
               	leaq	0x78(%rsp), %rdi
               	xorl	%esi, %esi
               	movq	%rsi, %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x78(%rsp), %rdi
               	leaq	0xa8(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x67, %eax
               	addq	$0xb8, %rsp
               	retq
               	movq	0xa8(%rsp), %rax
               	cmpl	$0x10, %eax
               	jne	<addr>
               	leaq	-<rip>, %rdx # <addr>
               	leaq	0x78(%rsp), %rdi
               	xorl	%esi, %esi
               	movq	%rsi, %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x78(%rsp), %rdi
               	leaq	0xa8(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x68, %eax
               	addq	$0xb8, %rsp
               	retq
               	movq	0xa8(%rsp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x69, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6a, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	-<rip>, %rdx # <addr>
               	leaq	0x78(%rsp), %rdi
               	xorl	%esi, %esi
               	movq	%rsi, %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x78(%rsp), %rdi
               	leaq	0xa8(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6b, %eax
               	addq	$0xb8, %rsp
               	retq
               	movq	0xa8(%rsp), %rax
               	cmpl	$0x10, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6c, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	-<rip>, %rdx # <addr>
               	leaq	0x78(%rsp), %rdi
               	xorl	%esi, %esi
               	movq	%rsi, %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x78(%rsp), %rdi
               	leaq	0xa8(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6d, %eax
               	addq	$0xb8, %rsp
               	retq
               	movq	0xa8(%rsp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x6e, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x70, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	0x20(%rsp), %rdx
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x6e, %rax
               	je	<addr>
               	movl	$0x71, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x72, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x73, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x10(%rsp), %rdi
               	movl	$0x2, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x75, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	0x10(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x76, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x77, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x23, %rax
               	je	<addr>
               	movl	$0x78, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0x79, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	-<rip>, %rdx # <addr>
               	leaq	0x78(%rsp), %rdi
               	xorl	%esi, %esi
               	movq	%rsi, %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x78(%rsp), %rdi
               	leaq	0xa8(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7a, %eax
               	addq	$0xb8, %rsp
               	retq
               	movq	0xa8(%rsp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7b, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x7c, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7d, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7e, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x80, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x81, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	-<rip>, %rdx # <addr>
               	leaq	0x78(%rsp), %rdi
               	xorl	%esi, %esi
               	movq	%rsi, %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x78(%rsp), %rdi
               	leaq	0xa8(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x82, %eax
               	addq	$0xb8, %rsp
               	retq
               	movq	0xa8(%rsp), %rax
               	cmpl	$0x10, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x83, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	-<rip>, %rdx # <addr>
               	leaq	0x78(%rsp), %rdi
               	xorl	%esi, %esi
               	movq	%rsi, %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x78(%rsp), %rdi
               	leaq	0xa8(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x84, %eax
               	addq	$0xb8, %rsp
               	retq
               	movq	0xa8(%rsp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x85, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x60(%rsp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	movq	%rsi, %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x88, %eax
               	addq	$0xb8, %rsp
               	retq
               	movl	$0x1, %r10d
               	movq	%r10, 0x8(%rsp)
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movq	0x8(%rsp), %r11
               	movl	%r11d, <rip> # <addr>
               	movl	$0x1, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	addq	$0x1, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	jle	<addr>
               	xorl	%esi, %esi
               	movq	0x60(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x92, %eax
               	addq	$0xb8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7a314, %eax          # imm = 0x7A314
               	je	<addr>
               	movl	$0x93, %eax
               	addq	$0xb8, %rsp
               	retq
               	xorl	%ecx, %ecx
               	leaq	0x60(%rsp), %rax
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rax,%rdx), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	movq	%rcx, (%rsp)
               	movq	%rsi, %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movl	$0x1, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	0x60(%rsp,%rcx,8), %rdi
               	xorl	%esi, %esi
               	movq	%rcx, (%rsp)
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x9d, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	0x20(%rsp), %rdx
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x6e, %rax
               	je	<addr>
               	movl	$0xa0, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x20(%rsp), %rdx
               	movq	$0x3b9aca00, 0x28(%rsp) # imm = 0x3B9ACA00
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0xa2, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	xorl	%edi, %edi
               	leaq	0x40(%rsp), %rsi
               	callq	<addr>
               	leaq	0x50(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x48(%rsp), %rax
               	addq	$0x2faf080, %rax        # imm = 0x2FAF080
               	movq	%rax, 0x58(%rsp)
               	cmpq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	jl	<addr>
               	subq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	movq	%rax, 0x58(%rsp)
               	addq	$0x1, 0x50(%rsp)
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	0x50(%rsp), %rdx
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	0x8(%rsp), %rax
               	cmpl	$0x6e, %eax
               	jne	<addr>
               	xorl	%edi, %edi
               	leaq	0xa0(%rsp), %rsi
               	callq	<addr>
               	movq	0xa0(%rsp), %rax
               	movq	0x40(%rsp), %rcx
               	subq	%rcx, %rax
               	imulq	$0x3e8, %rax, %rcx      # imm = 0x3E8
               	movq	0xa8(%rsp), %rax
               	movq	0x48(%rsp), %rdx
               	subq	%rdx, %rax
               	movabsq	$0x431bde82d7b634db, %rsi # imm = 0x431BDE82D7B634DB
               	imulq	%rsi
               	sarq	$0x12, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	cmpq	$0x32, %rax
               	jge	<addr>
               	movl	$0xa4, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa9, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x18(%rsp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xaa, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x80(%rsp), %rdi
               	leaq	0x18(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xab, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xac, %eax
               	addq	$0xb8, %rsp
               	retq
               	movl	$0x1, %edi
               	leaq	0x30(%rsp), %rsi
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	leaq	0x30(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x38(%rsp), %rax
               	addq	$0x2faf080, %rax        # imm = 0x2FAF080
               	movq	%rax, 0x48(%rsp)
               	cmpq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	jl	<addr>
               	subq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	movq	%rax, 0x48(%rsp)
               	addq	$0x1, 0x40(%rsp)
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	0x40(%rsp), %rdx
               	leaq	0x80(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	0x8(%rsp), %rax
               	cmpl	$0x6e, %eax
               	jne	<addr>
               	movl	$0x1, %edi
               	leaq	0x50(%rsp), %rsi
               	callq	<addr>
               	movq	0x50(%rsp), %rax
               	movq	0x30(%rsp), %rcx
               	subq	%rcx, %rax
               	imulq	$0x3e8, %rax, %rcx      # imm = 0x3E8
               	movq	0x58(%rsp), %rax
               	movq	0x38(%rsp), %rdx
               	subq	%rdx, %rax
               	movabsq	$0x431bde82d7b634db, %rsi # imm = 0x431BDE82D7B634DB
               	imulq	%rsi
               	sarq	$0x12, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	cmpq	$0x32, %rax
               	jge	<addr>
               	movl	$0xad, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x80(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xae, %eax
               	addq	$0xb8, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0xb8, %rsp
               	retq
               	movl	$0x9c, %eax
               	addq	$0xb8, %rsp
               	retq
               	movl	$0x96, %eax
               	addq	$0xb8, %rsp
               	retq
