
loop_carried_low_words.x64:	file format elf64-x86-64

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

<zero_extended>:
               	xorq	$-0x1, %rdi
               	leaq	<rip>, %rcx # <addr>
               	movl	%edi, %eax
               	leaq	-0x1(%rdx), %rdi
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	0x1(%rsi), %rdx
               	movzbq	(%rsi), %rsi
               	xorq	%rax, %rsi
               	andq	$0xff, %rsi
               	movl	(%rcx,%rsi,4), %esi
               	shrq	$0x8, %rax
               	xorq	%rsi, %rax
               	movq	%rdx, %rsi
               	movq	%rdi, %rdx
               	leaq	-0x1(%rdx), %rdi
               	testq	%rdx, %rdx
               	jne	<addr>
               	xorq	$-0x1, %rax
               	retq

<zero_extended_ref>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	$-0x1, %rdi
               	leaq	<rip>, %rax # <addr>
               	movl	%edi, -0x8(%rbp)
               	leaq	-0x1(%rdx), %rcx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	-0x8(%rbp), %edx
               	leaq	0x1(%rsi), %rdi
               	movzbq	(%rsi), %rsi
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	movl	(%rax,%rdx,4), %edx
               	movl	-0x8(%rbp), %esi
               	shrq	$0x8, %rsi
               	xorq	%rsi, %rdx
               	movl	%edx, -0x8(%rbp)
               	movq	%rdi, %rsi
               	movq	%rcx, %rdx
               	leaq	-0x1(%rdx), %rcx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	xorq	$-0x1, %rax
               	leave
               	retq

<sign_extended>:
               	movabsq	$-0x61c8864680b583eb, %rax # imm = 0x9E3779B97F4A7C15
               	imulq	%rdi, %rax
               	xorl	%ecx, %ecx
               	movslq	%eax, %rax
               	leaq	-0x1(%rdx), %r8
               	testq	%rdx, %rdx
               	je	<addr>
               	sarq	$0x3, %rax
               	leaq	<rip>, %rdx # <addr>
               	leaq	0x1(%rsi), %r9
               	movzbq	(%rsi), %rsi
               	movslq	(%rdx,%rsi,4), %rdx
               	xorq	%rdx, %rax
               	movl	$0x92492493, %edi       # imm = 0x92492493
               	imulq	%rax, %rdi
               	sarq	$0x22, %rdi
               	movq	%rdi, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdi, %rdx
               	addq	%rdx, %rcx
               	movq	%r9, %rsi
               	movq	%r8, %rdx
               	leaq	-0x1(%rdx), %r8
               	testq	%rdx, %rdx
               	jne	<addr>
               	xorq	%rcx, %rax
               	retq

<sign_extended_ref>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movabsq	$-0x61c8864680b583eb, %rax # imm = 0x9E3779B97F4A7C15
               	imulq	%rdi, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	$0x92492493, %ecx       # imm = 0x92492493
               	leaq	<rip>, %rdi # <addr>
               	movq	$0x0, -0x10(%rbp)
               	leaq	-0x1(%rdx), %r8
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	-0x8(%rbp), %rax
               	sarq	$0x3, %rax
               	leaq	0x1(%rsi), %rdx
               	movzbq	(%rsi), %rsi
               	movl	(%rdi,%rsi,4), %esi
               	xorq	%rsi, %rax
               	movl	%eax, -0x8(%rbp)
               	movq	-0x10(%rbp), %rsi
               	movslq	-0x8(%rbp), %rax
               	imulq	%rcx, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %rax
               	addq	%rsi, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, %rsi
               	movq	%r8, %rdx
               	leaq	-0x1(%rdx), %r8
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	movq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	leave
               	retq

<widened>:
               	movq	%rdi, %rax
               	shrq	$0x7, %rax
               	xorl	%ecx, %ecx
               	movl	$0x9e3779b1, %edi       # imm = 0x9E3779B1
               	leaq	-0x1(%rdx), %r8
               	testq	%rdx, %rdx
               	je	<addr>
               	imulq	%rdi, %rax
               	leaq	0x1(%rsi), %rdx
               	movzbq	(%rsi), %rsi
               	addq	%rsi, %rax
               	movl	%eax, %esi
               	shrq	$0x5, %rsi
               	addq	%rsi, %rcx
               	movq	%rdx, %rsi
               	movq	%r8, %rdx
               	leaq	-0x1(%rdx), %r8
               	testq	%rdx, %rdx
               	jne	<addr>
               	xorq	%rcx, %rax
               	retq

<widened_ref>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	shrq	$0x7, %rdi
               	movl	%edi, -0x8(%rbp)
               	movl	$0x9e3779b1, %eax       # imm = 0x9E3779B1
               	movq	$0x0, -0x10(%rbp)
               	leaq	-0x1(%rdx), %rcx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	-0x8(%rbp), %edx
               	imulq	%rax, %rdx
               	leaq	0x1(%rsi), %rdi
               	movzbq	(%rsi), %rsi
               	addq	%rsi, %rdx
               	movl	%edx, -0x8(%rbp)
               	movq	-0x10(%rbp), %rdx
               	movl	-0x8(%rbp), %esi
               	shrq	$0x5, %rsi
               	addq	%rsi, %rdx
               	movq	%rdx, -0x10(%rbp)
               	movq	%rdi, %rsi
               	movq	%rcx, %rdx
               	leaq	-0x1(%rdx), %rcx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	movq	-0x10(%rbp), %rcx
               	xorq	%rcx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x150, %rsp            # imm = 0x150
               	pushq	%r12
               	pushq	%rbx
               	xorl	%edx, %edx
               	movl	$0x80000000, %r9d       # imm = 0x80000000
               	movl	$0xedb88320, %esi       # imm = 0xEDB88320
               	leaq	<rip>, %rbx # <addr>
               	leaq	<rip>, %r12 # <addr>
               	xorl	%ecx, %ecx
               	movq	%rdx, %rax
               	movq	%rax, %rdi
               	shrq	%rdi
               	xorq	%rsi, %rdi
               	movq	%rax, %r8
               	shrq	%r8
               	testb	$0x1, %al
               	movq	%r8, %rax
               	cmovneq	%rdi, %rax
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jl	<addr>
               	movl	%eax, (%rbx,%rdx,4)
               	xorq	%r9, %rax
               	movl	%eax, (%r12,%rdx,4)
               	incq	%rdx
               	cmpl	$0x100, %edx            # imm = 0x100
               	jb	<addr>
               	xorl	%eax, %eax
               	leaq	-0x130(%rbp), %rcx
               	imulq	$0x25, %rax, %rdx
               	addq	$0xb, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x12c, %eax            # imm = 0x12C
               	jl	<addr>
               	leaq	-0x148(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	xorl	%ebx, %ebx
               	leaq	-0x148(%rbp), %rax
               	movq	(%rax,%rbx,8), %rdi
               	leaq	-0x130(%rbp), %rsi
               	movl	$0x12c, %edx            # imm = 0x12C
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	-0x148(%rbp), %rax
               	movq	(%rax,%rbx,8), %rdi
               	leaq	-0x130(%rbp), %rsi
               	movl	$0x12c, %edx            # imm = 0x12C
               	callq	<addr>
               	cmpl	%eax, %r12d
               	jne	<addr>
               	leaq	-0x148(%rbp), %rax
               	movq	(%rax,%rbx,8), %rdi
               	leaq	-0x130(%rbp), %rsi
               	xorl	%edx, %edx
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	-0x148(%rbp), %rax
               	movq	(%rax,%rbx,8), %rdi
               	leaq	-0x130(%rbp), %rsi
               	xorl	%edx, %edx
               	callq	<addr>
               	cmpl	%eax, %r12d
               	jne	<addr>
               	leaq	-0x148(%rbp), %rax
               	movq	(%rax,%rbx,8), %rdi
               	leaq	-0x130(%rbp), %rsi
               	movl	$0x12c, %edx            # imm = 0x12C
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	-0x148(%rbp), %rax
               	movq	(%rax,%rbx,8), %rdi
               	leaq	-0x130(%rbp), %rsi
               	movl	$0x12c, %edx            # imm = 0x12C
               	callq	<addr>
               	cmpl	%eax, %r12d
               	jne	<addr>
               	leaq	-0x148(%rbp), %rax
               	movq	(%rax,%rbx,8), %rdi
               	leaq	-0x130(%rbp), %rsi
               	xorl	%edx, %edx
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	-0x148(%rbp), %rax
               	movq	(%rax,%rbx,8), %rdi
               	leaq	-0x130(%rbp), %rsi
               	xorl	%edx, %edx
               	callq	<addr>
               	cmpl	%eax, %r12d
               	jne	<addr>
               	leaq	-0x148(%rbp), %rax
               	movq	(%rax,%rbx,8), %rdi
               	leaq	-0x130(%rbp), %rsi
               	movl	$0x12c, %edx            # imm = 0x12C
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	-0x148(%rbp), %rax
               	movq	(%rax,%rbx,8), %rdi
               	leaq	-0x130(%rbp), %rsi
               	movl	$0x12c, %edx            # imm = 0x12C
               	callq	<addr>
               	cmpl	%eax, %r12d
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x3, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	0xd(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	0xa(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	0x7(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	0x4(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	0x1(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
