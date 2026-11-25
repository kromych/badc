
loop_carried_low_words.x64:	file format elf64-x86-64

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

<zero_extended>:
               	xorq	$-0x1, %rdi
               	leaq	<rip>, %r8 # <addr>
               	movl	%edi, %eax
               	subq	$0x1, %rdx
               	jb	<addr>
               	incq	%rsi
               	movzbq	-0x1(%rsi), %rcx
               	xorq	%rax, %rcx
               	andq	$0xff, %rcx
               	movl	(%r8,%rcx,4), %ecx
               	shrq	$0x8, %rax
               	xorq	%rcx, %rax
               	subq	$0x1, %rdx
               	jae	<addr>
               	xorq	$-0x1, %rax
               	retq

<zero_extended_ref>:
               	subq	$0x18, %rsp
               	xorq	$-0x1, %rdi
               	leaq	<rip>, %r8 # <addr>
               	movl	%edi, 0x8(%rsp)
               	subq	$0x1, %rdx
               	jb	<addr>
               	movl	0x8(%rsp), %eax
               	incq	%rsi
               	movzbq	-0x1(%rsi), %rcx
               	xorq	%rcx, %rax
               	andq	$0xff, %rax
               	movl	(%r8,%rax,4), %ecx
               	movl	0x8(%rsp), %eax
               	shrq	$0x8, %rax
               	xorq	%rax, %rcx
               	movl	%ecx, 0x8(%rsp)
               	subq	$0x1, %rdx
               	jae	<addr>
               	movl	0x8(%rsp), %eax
               	xorq	$-0x1, %rax
               	addq	$0x18, %rsp
               	retq

<sign_extended>:
               	movabsq	$-0x61c8864680b583eb, %rax # imm = 0x9E3779B97F4A7C15
               	imulq	%rdi, %rax
               	xorl	%ecx, %ecx
               	movl	$0x92492493, %r8d       # imm = 0x92492493
               	leaq	<rip>, %r9 # <addr>
               	movslq	%eax, %rax
               	subq	$0x1, %rdx
               	jb	<addr>
               	sarq	$0x3, %rax
               	incq	%rsi
               	movzbq	-0x1(%rsi), %rdi
               	movslq	(%r9,%rdi,4), %rdi
               	xorq	%rdi, %rax
               	movq	%rax, %rdi
               	imulq	%r8, %rdi
               	sarq	$0x22, %rdi
               	movq	%rdi, %r10
               	shrq	$0x3f, %r10
               	addq	%r10, %rdi
               	addq	%rdi, %rcx
               	subq	$0x1, %rdx
               	jae	<addr>
               	xorq	%rcx, %rax
               	retq

<sign_extended_ref>:
               	subq	$0x18, %rsp
               	movabsq	$-0x61c8864680b583eb, %rax # imm = 0x9E3779B97F4A7C15
               	imulq	%rdi, %rax
               	movl	%eax, 0x8(%rsp)
               	movl	$0x92492493, %ecx       # imm = 0x92492493
               	leaq	<rip>, %rdi # <addr>
               	movq	$0x0, (%rsp)
               	subq	$0x1, %rdx
               	jb	<addr>
               	movslq	0x8(%rsp), %rax
               	sarq	$0x3, %rax
               	incq	%rsi
               	movzbq	-0x1(%rsi), %r8
               	movl	(%rdi,%r8,4), %r8d
               	xorq	%r8, %rax
               	movl	%eax, 0x8(%rsp)
               	movq	(%rsp), %r8
               	movslq	0x8(%rsp), %rax
               	imulq	%rcx, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %rax
               	addq	%r8, %rax
               	movq	%rax, (%rsp)
               	subq	$0x1, %rdx
               	jae	<addr>
               	movl	0x8(%rsp), %eax
               	movq	(%rsp), %rcx
               	xorq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq

<widened>:
               	shrq	$0x7, %rdi
               	xorl	%eax, %eax
               	movl	$0x9e3779b1, %r8d       # imm = 0x9E3779B1
               	subq	$0x1, %rdx
               	jb	<addr>
               	movq	%rdi, %rcx
               	imulq	%r8, %rcx
               	incq	%rsi
               	movzbq	-0x1(%rsi), %rdi
               	addq	%rcx, %rdi
               	movl	%edi, %ecx
               	shrq	$0x5, %rcx
               	addq	%rcx, %rax
               	subq	$0x1, %rdx
               	jae	<addr>
               	xorq	%rax, %rdi
               	movq	%rdi, %rax
               	retq

<widened_ref>:
               	subq	$0x18, %rsp
               	shrq	$0x7, %rdi
               	movl	%edi, 0x8(%rsp)
               	movl	$0x9e3779b1, %ecx       # imm = 0x9E3779B1
               	movq	$0x0, (%rsp)
               	subq	$0x1, %rdx
               	jb	<addr>
               	movl	0x8(%rsp), %eax
               	imulq	%rcx, %rax
               	incq	%rsi
               	movzbq	-0x1(%rsi), %rdi
               	addq	%rdi, %rax
               	movl	%eax, 0x8(%rsp)
               	movq	(%rsp), %rdi
               	movl	0x8(%rsp), %eax
               	shrq	$0x5, %rax
               	addq	%rdi, %rax
               	movq	%rax, (%rsp)
               	subq	$0x1, %rdx
               	jae	<addr>
               	movl	0x8(%rsp), %eax
               	movq	(%rsp), %rcx
               	xorq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x158, %rsp            # imm = 0x158
               	pushq	%r12
               	pushq	%rbx
               	xorl	%esi, %esi
               	movl	$0x80000000, %r9d       # imm = 0x80000000
               	movl	$0xedb88320, %edi       # imm = 0xEDB88320
               	leaq	<rip>, %r10 # <addr>
               	leaq	<rip>, %r11 # <addr>
               	xorl	%ecx, %ecx
               	movq	%rsi, %rax
               	movq	%rax, %rdx
               	shrq	%rdx
               	xorq	%rdi, %rdx
               	movq	%rax, %r8
               	shrq	%r8
               	testb	$0x1, %al
               	movq	%r8, %rax
               	cmovneq	%rdx, %rax
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jl	<addr>
               	movl	%eax, (%r10,%rsi,4)
               	xorq	%r9, %rax
               	movl	%eax, (%r11,%rsi,4)
               	incq	%rsi
               	nopl	(%rax,%rax)
               	cmpl	$0x100, %esi            # imm = 0x100
               	jb	<addr>
               	xorl	%eax, %eax
               	imulq	$0x25, %rax, %rcx
               	addq	$0xb, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x30(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x12c, %eax            # imm = 0x12C
               	jl	<addr>
               	leaq	0x18(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	xorl	%ebx, %ebx
               	movq	0x18(%rsp,%rbx,8), %rdi
               	leaq	0x30(%rsp), %rsi
               	movl	$0x12c, %edx            # imm = 0x12C
               	callq	<addr>
               	movq	%rax, %r12
               	movq	0x18(%rsp,%rbx,8), %rdi
               	leaq	0x30(%rsp), %rsi
               	movl	$0x12c, %edx            # imm = 0x12C
               	callq	<addr>
               	cmpl	%eax, %r12d
               	jne	<addr>
               	movq	0x18(%rsp,%rbx,8), %rdi
               	leaq	0x30(%rsp), %rsi
               	xorl	%edx, %edx
               	callq	<addr>
               	movq	%rax, %r12
               	movq	0x18(%rsp,%rbx,8), %rdi
               	leaq	0x30(%rsp), %rsi
               	xorl	%edx, %edx
               	callq	<addr>
               	cmpl	%eax, %r12d
               	jne	<addr>
               	movq	0x18(%rsp,%rbx,8), %rdi
               	leaq	0x30(%rsp), %rsi
               	movl	$0x12c, %edx            # imm = 0x12C
               	callq	<addr>
               	movq	%rax, %r12
               	movq	0x18(%rsp,%rbx,8), %rdi
               	leaq	0x30(%rsp), %rsi
               	movl	$0x12c, %edx            # imm = 0x12C
               	callq	<addr>
               	cmpl	%eax, %r12d
               	jne	<addr>
               	movq	0x18(%rsp,%rbx,8), %rdi
               	leaq	0x30(%rsp), %rsi
               	xorl	%edx, %edx
               	callq	<addr>
               	movq	%rax, %r12
               	movq	0x18(%rsp,%rbx,8), %rdi
               	leaq	0x30(%rsp), %rsi
               	xorl	%edx, %edx
               	callq	<addr>
               	cmpl	%eax, %r12d
               	jne	<addr>
               	movq	0x18(%rsp,%rbx,8), %rdi
               	leaq	0x30(%rsp), %rsi
               	movl	$0x12c, %edx            # imm = 0x12C
               	callq	<addr>
               	movq	%rax, %r12
               	movq	0x18(%rsp,%rbx,8), %rdi
               	leaq	0x30(%rsp), %rsi
               	movl	$0x12c, %edx            # imm = 0x12C
               	callq	<addr>
               	cmpl	%eax, %r12d
               	jne	<addr>
               	incq	%rbx
               	nopl	(%rax,%rax)
               	cmpl	$0x3, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x158, %rsp            # imm = 0x158
               	retq
               	leaq	0xd(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	addq	$0x158, %rsp            # imm = 0x158
               	retq
               	leaq	0xa(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	addq	$0x158, %rsp            # imm = 0x158
               	retq
               	leaq	0x7(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	addq	$0x158, %rsp            # imm = 0x158
               	retq
               	leaq	0x4(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	addq	$0x158, %rsp            # imm = 0x158
               	retq
               	leaq	0x1(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	addq	$0x158, %rsp            # imm = 0x158
               	retq
