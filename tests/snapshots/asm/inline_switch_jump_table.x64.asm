
inline_switch_jump_table.x64:	file format elf64-x86-64

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

<use>:
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	cmpq	$0xc, %rsi
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rsi,8), %r10
               	jmpq	*%r10
               	movl	$0x2, %ecx
               	movl	$0xc8, %edx
               	cmpq	$0xc, %rdi
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdi,8), %r10
               	jmpq	*%r10
               	movl	$0x65, %eax
               	movq	%rdx, %rsi
               	subq	%rdi, %rsi
               	leaq	0x1(%rdi), %rdx
               	movslq	%edx, %r9
               	cmpq	$0xc, %r9
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%r9,8), %r10
               	jmpq	*%r10
               	leaq	0x1(%rax), %rdx
               	movq	%rsi, %r8
               	subq	%r9, %r8
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	addq	%rcx, %rax
               	addq	%rsi, %rax
               	imulq	$0xa, %rdx, %rcx
               	addq	%rcx, %rax
               	leaq	(%rax,%r8), %rcx
               	cmpq	$0xc, %rdi
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdi,8), %r10
               	jmpq	*%r10
               	movl	$0x64, %eax
               	addq	%rcx, %rax
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
               	leaq	0x8(%rax), %rdx
               	jmp	<addr>
               	leaq	0xf(%rax), %rdx
               	jmp	<addr>
               	leaq	0x16(%rax), %rdx
               	jmp	<addr>
               	leaq	0x1d(%rax), %rdx
               	jmp	<addr>
               	leaq	0x24(%rax), %rdx
               	jmp	<addr>
               	leaq	0x2b(%rax), %rdx
               	jmp	<addr>
               	leaq	0x32(%rax), %rdx
               	jmp	<addr>
               	leaq	0x39(%rax), %rdx
               	jmp	<addr>
               	leaq	0x40(%rax), %rdx
               	jmp	<addr>
               	leaq	0x47(%rax), %rdx
               	jmp	<addr>
               	leaq	0x4e(%rax), %rdx
               	jmp	<addr>
               	movq	$-0x1, %r8
               	movq	%r8, %rdx
               	jmp	<addr>
               	movl	$0x6c, %eax
               	jmp	<addr>
               	movl	$0x73, %eax
               	jmp	<addr>
               	movl	$0x7a, %eax
               	jmp	<addr>
               	movl	$0x81, %eax
               	jmp	<addr>
               	movl	$0x88, %eax
               	jmp	<addr>
               	movl	$0x8f, %eax
               	jmp	<addr>
               	movl	$0x96, %eax
               	jmp	<addr>
               	movl	$0x9d, %eax
               	jmp	<addr>
               	movl	$0xa4, %eax
               	jmp	<addr>
               	movl	$0xab, %eax
               	jmp	<addr>
               	movl	$0xb2, %eax
               	jmp	<addr>
               	movq	$-0x1, %rsi
               	movq	%rsi, %rax
               	jmp	<addr>
               	movl	$0x5, %ecx
               	jmp	<addr>
               	movl	$0x8, %ecx
               	jmp	<addr>
               	movl	$0xb, %ecx
               	jmp	<addr>
               	movl	$0xe, %ecx
               	jmp	<addr>
               	movl	$0x11, %ecx
               	jmp	<addr>
               	movl	$0x14, %ecx
               	jmp	<addr>
               	movl	$0x17, %ecx
               	jmp	<addr>
               	movl	$0x1a, %ecx
               	jmp	<addr>
               	movl	$0x1d, %ecx
               	jmp	<addr>
               	movl	$0x20, %ecx
               	jmp	<addr>
               	movl	$0x23, %ecx
               	jmp	<addr>
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
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
               	imulq	$0x7, %r13, %r15
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
               	movslq	%r15d, %rdx
               	addq	%rdi, %rdx
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
               	leaq	0x64(%r12), %rcx
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
