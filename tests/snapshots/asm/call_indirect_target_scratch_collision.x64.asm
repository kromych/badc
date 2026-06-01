
call_indirect_target_scratch_collision.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r8
               	movq	(%r8), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %rdi
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %rax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	%ecx, %rcx
               	xorq	%rax, %rax
               	movzbq	(%rsi), %rsi
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, (%r8)
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movq	%rdx, %r14
               	movslq	%ecx, %rcx
               	movq	%r8, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	(%rbx), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	%rcx, %r15
               	andq	$0xffff, %r15           # imm = 0xFFFF
               	movq	0x20(%rsp), %r11
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movq	0x28(%rsp), %r8
               	callq	*%r11
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0x8(%rbp), %r11
               	leaq	-<rip>, %r9        # <addr>
               	movq	%r9, (%r11)
               	xorq	%rbx, %rbx
               	movl	%ebx, -0x10(%rbp)
               	leaq	-0x8(%rbp), %r12
               	leaq	<rip>, %r14
               	movl	$0x1ffff, %r10d         # imm = 0x1FFFF
               	movq	%r10, 0x28(%rsp)
               	leaq	-0x10(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movq	0x28(%rsp), %rcx
               	movq	0x20(%rsp), %r8
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %rbx
               	movslq	%r15d, %r14
               	movslq	-0x10(%rbp), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%r15d, %r15
               	cmpq	$0x0, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x48(%rbp)
               	cmpq	$0x0, %r15
               	je	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpq	$0x10040, %rax          # imm = 0x10040
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	movq	-0x48(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	xorq	%r15, %r15
               	movq	%r15, -0x50(%rbp)
               	jmp	<addr>
               	movl	$0x1, %r15d
               	movq	%r15, -0x50(%rbp)
               	jmp	<addr>
               	movq	-0x50(%rbp), %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
