
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
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
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
               	movslq	%edi, %rdx
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rsi
               	incq	%rsi
               	movq	%rsi, (%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movq	0x8(%rcx), %rsi
               	subq	%rdx, %rsi
               	movq	%rsi, 0x8(%rcx)
               	movq	(%rcx), %r8
               	movq	0x8(%rcx), %r9
               	leaq	0x1(%rdi), %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x10(%rbp), %rsi
               	movq	%r8, (%rsi)
               	movq	%r9, 0x8(%rsi)
               	cmpq	$0xc, %rcx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rcx,8), %r10
               	jmpq	*%r10
               	leaq	-0x10(%rbp), %rsi
               	movq	(%rsi), %rbx
               	incq	%rbx
               	movq	%rbx, (%rsi)
               	leaq	-0x10(%rbp), %rsi
               	movq	0x8(%rsi), %rbx
               	movq	%rcx, %r10
               	movq	%rbx, %rcx
               	subq	%r10, %rcx
               	movq	%rcx, 0x8(%rsi)
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rsi
               	movq	0x8(%rcx), %rcx
               	imulq	$0x3e8, %r8, %r8        # imm = 0x3E8
               	addq	%r8, %rax
               	addq	%r9, %rax
               	imulq	$0xa, %rsi, %rsi
               	addq	%rsi, %rax
               	addq	%rax, %rcx
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	movl	$0x64, %eax
               	addq	%rcx, %rax
               	movq	(%rsp), %rbx
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
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rsi
               	movq	(%rsi), %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%rsi)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rsi
               	movq	(%rsi), %rbx
               	addq	$0xf, %rbx
               	movq	%rbx, (%rsi)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rsi
               	movq	(%rsi), %rbx
               	addq	$0x16, %rbx
               	movq	%rbx, (%rsi)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rsi
               	movq	(%rsi), %rbx
               	addq	$0x1d, %rbx
               	movq	%rbx, (%rsi)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rsi
               	movq	(%rsi), %rbx
               	addq	$0x24, %rbx
               	movq	%rbx, (%rsi)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rsi
               	movq	(%rsi), %rbx
               	addq	$0x2b, %rbx
               	movq	%rbx, (%rsi)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rsi
               	movq	(%rsi), %rbx
               	addq	$0x32, %rbx
               	movq	%rbx, (%rsi)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rsi
               	movq	(%rsi), %rbx
               	addq	$0x39, %rbx
               	movq	%rbx, (%rsi)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rsi
               	movq	(%rsi), %rbx
               	addq	$0x40, %rbx
               	movq	%rbx, (%rsi)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rsi
               	movq	(%rsi), %rbx
               	addq	$0x47, %rbx
               	movq	%rbx, (%rsi)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rsi
               	movq	(%rsi), %rbx
               	addq	$0x4e, %rbx
               	movq	%rbx, (%rsi)
               	jmp	<addr>
               	movabsq	$-0x1, %rbx
               	movq	%rbx, (%rsi)
               	leaq	-0x10(%rbp), %rcx
               	movq	%rbx, 0x8(%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rsi
               	addq	$0xf, %rsi
               	movq	%rsi, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rsi
               	addq	$0x16, %rsi
               	movq	%rsi, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rsi
               	addq	$0x1d, %rsi
               	movq	%rsi, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rsi
               	addq	$0x24, %rsi
               	movq	%rsi, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rsi
               	addq	$0x2b, %rsi
               	movq	%rsi, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rsi
               	addq	$0x32, %rsi
               	movq	%rsi, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rsi
               	addq	$0x39, %rsi
               	movq	%rsi, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rsi
               	addq	$0x40, %rsi
               	movq	%rsi, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rsi
               	addq	$0x47, %rsi
               	movq	%rsi, (%rcx)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rsi
               	addq	$0x4e, %rsi
               	movq	%rsi, (%rcx)
               	jmp	<addr>
               	movabsq	$-0x1, %rsi
               	movq	%rsi, (%rcx)
               	movq	%rsi, 0x8(%rcx)
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
               	movslq	%eax, %rax
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
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	retq
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	movabsq	$-0x1, %rcx
               	movq	%rcx, %r8
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	movq	%rax, %rsi
               	jmp	<addr>
               	movl	$0x3e8, %edx            # imm = 0x3E8
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movabsq	$-0x2, %r12
               	cmpl	$0xf, %r12d
               	jge	<addr>
               	movabsq	$-0x2, %rbx
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
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
