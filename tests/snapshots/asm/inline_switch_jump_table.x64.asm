
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
               	leaq	-0x10(%rbp), %rcx
               	movq	$0x64, -0x10(%rbp)
               	movq	$0xc8, -0x8(%rbp)
               	cmpq	$0xc, %rdi
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdi,8), %r10
               	jmpq	*%r10
               	movq	-0x10(%rbp), %rcx
               	incq	%rcx
               	movq	%rcx, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	movq	-0x8(%rbp), %rdx
               	subq	%rdi, %rdx
               	movq	%rdx, -0x8(%rbp)
               	movq	(%rcx), %rsi
               	movq	0x8(%rcx), %r8
               	leaq	0x1(%rdi), %rcx
               	movslq	%ecx, %rdx
               	movq	%rsi, -0x10(%rbp)
               	movq	%r8, -0x8(%rbp)
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	movq	-0x10(%rbp), %rcx
               	incq	%rcx
               	movq	%rcx, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	movq	-0x8(%rbp), %r9
               	subq	%rdx, %r9
               	movq	%r9, -0x8(%rbp)
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
               	movq	-0x10(%rbp), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rcx
               	addq	$0xf, %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rcx
               	addq	$0x16, %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rcx
               	addq	$0x1d, %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rcx
               	addq	$0x24, %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rcx
               	addq	$0x2b, %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rcx
               	addq	$0x32, %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rcx
               	addq	$0x39, %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rcx
               	addq	$0x40, %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rcx
               	addq	$0x47, %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rcx
               	addq	$0x4e, %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	movq	$-0x1, -0x10(%rbp)
               	movq	$-0x1, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	jmp	<addr>
               	movq	-0x10(%rbp), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rcx
               	addq	$0xf, %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rcx
               	addq	$0x16, %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rcx
               	addq	$0x1d, %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rcx
               	addq	$0x24, %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rcx
               	addq	$0x2b, %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rcx
               	addq	$0x32, %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rcx
               	addq	$0x39, %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rcx
               	addq	$0x40, %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rcx
               	addq	$0x47, %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rcx
               	addq	$0x4e, %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	movq	$-0x1, -0x10(%rbp)
               	movq	$-0x1, -0x8(%rbp)
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	$-0x2, %r12
               	movq	$-0x2, %rbx
               	leaq	0x1(%r12), %r13
               	imulq	$0x7, %r12, %rax
               	addq	$0x64, %rax
               	incq	%rax
               	movslq	%eax, %r14
               	imulq	$0x7, %r13, %rax
               	movslq	%eax, %r15
               	leaq	0x64(%r12), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	testl	%ebx, %ebx
               	jl	<addr>
               	cmpl	$0xc, %ebx
               	jge	<addr>
               	leaq	(%rbx,%rbx,2), %rcx
               	addq	$0x2, %rcx
               	movslq	%ecx, %rsi
               	testl	%r12d, %r12d
               	jl	<addr>
               	cmpl	$0xc, %r12d
               	jge	<addr>
               	movl	$0xc8, %ecx
               	subq	%r12, %rcx
               	movq	%r14, %rdi
               	testl	%r13d, %r13d
               	jl	<addr>
               	cmpl	$0xc, %r13d
               	jge	<addr>
               	leaq	(%rdi,%r15), %rdx
               	leaq	0x1(%rdx), %r8
               	movq	%rcx, %rdx
               	subq	%r13, %rdx
               	imulq	$0x3e8, %rdi, %rdi      # imm = 0x3E8
               	addq	%rdi, %rsi
               	addq	%rsi, %rcx
               	imulq	$0xa, %r8, %rsi
               	addq	%rsi, %rcx
               	addq	%rcx, %rdx
               	testl	%r12d, %r12d
               	jl	<addr>
               	cmpl	$0xa, %r12d
               	jg	<addr>
               	movq	0x38(%rsp), %rcx
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	jmp	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	movq	$-0x1, %rdx
               	movq	%rdx, %r8
               	jmp	<addr>
               	movq	$-0x1, %rcx
               	movq	%rcx, %rdi
               	jmp	<addr>
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	jmp	<addr>
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
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
