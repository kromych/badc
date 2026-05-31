
typedef_basic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400247 <.text+0x27>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	movq	%r11, %r8
               	addq	%r9, %r8
               	movslq	%r8d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x64, %r11d
               	movl	$0x41, %r10d
               	movq	%r10, 0x28(%rsp)
               	movl	$0x499602d2, %r12d      # imm = 0x499602D2
               	leaq	0xfe4d(%rip), %r14      # 0x4100d0
               	leaq	-0x30(%rbp), %rsi
               	movl	$0x7, %edx
               	movl	%edx, (%rsi)
               	leaq	-0x30(%rbp), %rcx
               	movq	%rcx, %rdx
               	addq	$0x8, %rdx
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rdx)
               	leaq	-0x38(%rbp), %rsi
               	movl	$0xb, %ecx
               	movl	%ecx, (%rsi)
               	leaq	-0x38(%rbp), %rdx
               	movq	%rdx, %rcx
               	addq	$0x4, %rcx
               	movl	$0x16, %edx
               	movl	%edx, (%rcx)
               	leaq	-0x48(%rbp), %rsi
               	movl	$0x1, %edx
               	movl	%edx, (%rsi)
               	leaq	-0x48(%rbp), %rcx
               	movq	%rcx, %rdx
               	addq	$0x4, %rdx
               	movl	$0x2, %ecx
               	movl	%ecx, (%rdx)
               	leaq	-0x48(%rbp), %rsi
               	movq	%rsi, %rcx
               	addq	$0x8, %rcx
               	movl	$0x3, %esi
               	movl	%esi, (%rcx)
               	movslq	%r11d, %r15
               	movq	0x28(%rsp), %rbx
               	andq	$0xff, %rbx
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0xa5, %rax
               	je	0x400345 <.text+0x125>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%r14), %rbx
               	movq	%rbx, %r14
               	xorq	$0x68, %r14
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r14, %rbx
               	cmpq	$0x0, %rbx
               	je	0x40038f <.text+0x16f>
               	movl	$0x2, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %r14
               	movslq	(%r14), %rbx
               	cmpq	$0x7, %rbx
               	je	0x4003ca <.text+0x1aa>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %r14
               	movslq	(%r14), %rbx
               	leaq	-0x38(%rbp), %r14
               	movq	%r14, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r14
               	movq	%rbx, %rax
               	addq	%r14, %rax
               	movslq	%eax, %rax
               	cmpq	$0x21, %rax
               	je	0x40041f <.text+0x1ff>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %r14
               	movslq	(%r14), %rax
               	leaq	-0x48(%rbp), %r14
               	movq	%r14, %rbx
               	addq	$0x4, %rbx
               	movslq	(%rbx), %r14
               	movq	%rax, %rbx
               	addq	%r14, %rbx
               	movslq	%ebx, %rbx
               	leaq	-0x48(%rbp), %r14
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r14
               	movq	%rbx, %rax
               	addq	%r14, %rax
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	0x40048e <.text+0x26e>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x499602d2, %r12       # imm = 0x499602D2
               	je	0x4004c3 <.text+0x2a3>
               	movl	$0x6, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movq	0x28(%rsp), %r14
               	andq	$0xff, %r14
               	cmpq	$0x41, %r14
               	je	0x400504 <.text+0x2e4>
               	movl	$0x7, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	je	0x40053c <.text+0x31c>
               	movl	$0x8, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	je	0x400574 <.text+0x354>
               	movl	$0x9, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
