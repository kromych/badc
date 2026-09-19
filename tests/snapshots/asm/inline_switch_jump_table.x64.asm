
inline_switch_jump_table.x64:	file format elf64-x86-64

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

<use>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	cmpq	$0xc, %rsi
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rsi,8), %r10
               	jmpq	*%r10
               	movl	$0x2, %eax
               	movl	$0x64, %edx
               	movl	$0xc8, %esi
               	leaq	-0x10(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	cmpq	$0xc, %rdi
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdi,8), %r10
               	jmpq	*%r10
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rdx
               	incq	%rdx
               	movq	%rdx, (%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movq	0x8(%rcx), %rdx
               	subq	%rdi, %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	(%rcx), %rsi
               	movq	0x8(%rcx), %r8
               	leaq	0x1(%rdi), %rcx
               	movslq	%ecx, %rdx
               	leaq	-0x10(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	movq	%r8, 0x8(%rcx)
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %r9
               	incq	%r9
               	movq	%r9, (%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movq	0x8(%rcx), %r9
               	movq	%rdx, %r10
               	movq	%r9, %rdx
               	subq	%r10, %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	imulq	$0x3e8, %rsi, %rsi      # imm = 0x3E8
               	addq	%rsi, %rax
               	addq	%r8, %rax
               	imulq	$0xa, %rdx, %rdx
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	cmpq	$0xc, %rdi
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdi,8), %r10
               	jmpq	*%r10
               	movl	$0x64, %eax
               	addq	%rcx, %rax
               	leave
               	retq
               	movl	$0x65, %eax
               	jmp	<addr>
               	movl	$0x66, %eax
               	jmp	<addr>
               	movl	$0x67, %eax
               	jmp	<addr>
               	movl	$0x68, %eax
               	jmp	<addr>
               	movl	$0x69, %eax
               	jmp	<addr>
               	movl	$0x6a, %eax
               	jmp	<addr>
               	movl	$0x6b, %eax
               	jmp	<addr>
               	movl	$0x6c, %eax
               	jmp	<addr>
               	movl	$0x6d, %eax
               	jmp	<addr>
               	movl	$0x6e, %eax
               	jmp	<addr>
               	movq	$-0x1, %rax
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %r9
               	addq	$0x8, %r9
               	movq	%r9, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %r9
               	addq	$0xf, %r9
               	movq	%r9, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %r9
               	addq	$0x16, %r9
               	movq	%r9, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %r9
               	addq	$0x1d, %r9
               	movq	%r9, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %r9
               	addq	$0x24, %r9
               	movq	%r9, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %r9
               	addq	$0x2b, %r9
               	movq	%r9, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %r9
               	addq	$0x32, %r9
               	movq	%r9, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %r9
               	addq	$0x39, %r9
               	movq	%r9, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %r9
               	addq	$0x40, %r9
               	movq	%r9, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %r9
               	addq	$0x47, %r9
               	movq	%r9, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %r9
               	addq	$0x4e, %r9
               	movq	%r9, (%rcx)
               	jmp	<addr>
               	movq	$-0x1, %rdx
               	movq	%rdx, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rdx
               	addq	$0xf, %rdx
               	movq	%rdx, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rdx
               	addq	$0x16, %rdx
               	movq	%rdx, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rdx
               	addq	$0x1d, %rdx
               	movq	%rdx, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rdx
               	addq	$0x24, %rdx
               	movq	%rdx, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rdx
               	addq	$0x2b, %rdx
               	movq	%rdx, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rdx
               	addq	$0x32, %rdx
               	movq	%rdx, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rdx
               	addq	$0x39, %rdx
               	movq	%rdx, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rdx
               	addq	$0x40, %rdx
               	movq	%rdx, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rdx
               	addq	$0x47, %rdx
               	movq	%rdx, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rdx
               	addq	$0x4e, %rdx
               	movq	%rdx, (%rcx)
               	jmp	<addr>
               	movq	$-0x1, %rdx
               	movq	%rdx, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	jmp	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	movl	$0x8, %eax
               	jmp	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	movl	$0xe, %eax
               	jmp	<addr>
               	movl	$0x11, %eax
               	jmp	<addr>
               	movl	$0x14, %eax
               	jmp	<addr>
               	movl	$0x17, %eax
               	jmp	<addr>
               	movl	$0x1a, %eax
               	jmp	<addr>
               	movl	$0x1d, %eax
               	jmp	<addr>
               	movl	$0x20, %eax
               	jmp	<addr>
               	movl	$0x23, %eax
               	jmp	<addr>
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	jmp	<addr>

<expect>:
               	movslq	%edi, %rdi
               	testl	%esi, %esi
               	jl	<addr>
               	cmpl	$0xc, %esi
               	jge	<addr>
               	leaq	(%rsi,%rsi,2), %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rdx
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rcx
               	testl	%edi, %edi
               	jl	<addr>
               	cmpl	$0xc, %edi
               	jge	<addr>
               	imulq	$0x7, %rdi, %rax
               	addq	$0x64, %rax
               	incq	%rax
               	movslq	%eax, %rsi
               	movl	$0xc8, %eax
               	subq	%rdi, %rax
               	testl	%ecx, %ecx
               	jl	<addr>
               	cmpl	$0xc, %ecx
               	jge	<addr>
               	imulq	$0x7, %rcx, %r8
               	movslq	%r8d, %r8
               	addq	%rsi, %r8
               	incq	%r8
               	movq	%rcx, %r10
               	movq	%rax, %rcx
               	subq	%r10, %rcx
               	imulq	$0x3e8, %rsi, %rsi      # imm = 0x3E8
               	addq	%rsi, %rdx
               	addq	%rdx, %rax
               	imulq	$0xa, %r8, %rdx
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	testl	%edi, %edi
               	jl	<addr>
               	cmpl	$0xa, %edi
               	jg	<addr>
               	leaq	0x64(%rdi), %rax
               	addq	%rcx, %rax
               	retq
               	movq	$-0x1, %rax
               	jmp	<addr>
               	movq	$-0x1, %rcx
               	movq	%rcx, %r8
               	jmp	<addr>
               	movq	$-0x1, %rax
               	movq	%rax, %rsi
               	jmp	<addr>
               	movl	$0x3e8, %edx            # imm = 0x3E8
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	$-0x2, %r12
               	cmpl	$0xf, %r12d
               	jge	<addr>
               	movq	$-0x2, %rbx
               	cmpl	$0xf, %ebx
               	jge	<addr>
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0xf, %ebx
               	jl	<addr>
               	incq	%r12
               	cmpl	$0xf, %r12d
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
