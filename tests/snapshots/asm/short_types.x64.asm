
short_types.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%r12, %rcx
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movslq	%eax, %rcx
               	andq	$0x8000, %rcx           # imm = 0x8000
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movslq	%eax, %rax
               	subq	$0x10000, %rax          # imm = 0x10000
               	movslq	%eax, %rax
               	retq
               	movslq	%eax, %rax
               	retq
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x4d2, %eax            # imm = 0x4D2
               	movabsq	$-0x2a, %rcx
               	cmpq	$0x4d2, %rax            # imm = 0x4D2
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$-0x2a, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rdx
               	addq	%rcx, %rdx
               	movslq	%edx, %rdx
               	movswq	%dx, %rdx
               	cmpq	$0x4a8, %rdx            # imm = 0x4A8
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	movslq	%edx, %rdx
               	movswq	%dx, %rdx
               	cmpq	$0x4fc, %rdx            # imm = 0x4FC
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	imulq	$0x3, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movswq	%cx, %rcx
               	cmpq	$-0x7e, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %ecx
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movswq	%cx, %rcx
               	cmpq	$0xb0, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %ecx
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rax
               	popq	%rdx
               	movswq	%ax, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ebx
               	movq	%rbx, %rax
               	shlq	$0xe, %rax
               	movswq	%ax, %rax
               	cmpq	$0x4000, %rax           # imm = 0x4000
               	je	<addr>
               	movl	$0x8, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rdi
               	shlq	$0x10, %rdi
               	callq	<addr>
               	movswq	%ax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rdi
               	shlq	$0xf, %rdi
               	callq	<addr>
               	movswq	%ax, %rax
               	cmpq	$-0x8000, %rax          # imm = 0x8000
               	je	<addr>
               	movl	$0xa, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x8, %rax
               	sarq	$0x1, %rax
               	movswq	%ax, %rax
               	cmpq	$-0x4, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xfffe, %eax           # imm = 0xFFFE
               	movl	$0x1, %ecx
               	movq	%rax, %rdx
               	addq	%rcx, %rdx
               	movslq	%edx, %rdx
               	movslq	%edx, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	xorq	$0xffff, %rdx           # imm = 0xFFFF
               	movl	%edx, %edx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movl	$0xc, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	movl	$0x1, %edx
               	movq	%rdx, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movslq	%esi, %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	movl	$0xe, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movslq	%eax, %rsi
               	cmpq	$0xffff, %rsi           # imm = 0xFFFF
               	je	<addr>
               	movl	$0xf, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movslq	%eax, %rax
               	movl	%eax, %eax
               	cmpq	%rdx, %rax
               	ja	<addr>
               	movl	$0x10, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	shlq	$0xf, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	$0x8000, %rax           # imm = 0x8000
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8000, %eax           # imm = 0x8000
               	movslq	%eax, %rax
               	sarq	$0x1, %rax
               	movslq	%eax, %rax
               	cmpq	$0x4000, %rax           # imm = 0x4000
               	je	<addr>
               	movl	$0x12, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xd8(%rbp), %rax
               	movl	$0x64, %ecx
               	movw	%cx, (%rax)
               	leaq	-0xd8(%rbp), %rax
               	addq	$0x2, %rax
               	movl	$0xc8, %ecx
               	movw	%cx, (%rax)
               	leaq	-0xd8(%rbp), %rax
               	addq	$0x4, %rax
               	movabsq	$-0x12c, %rcx           # imm = 0xFED4
               	movw	%cx, (%rax)
               	leaq	-0xd8(%rbp), %rax
               	movq	%rax, %rbx
               	addq	$0x6, %rbx
               	leaq	-0xd8(%rbp), %rax
               	movswq	(%rax), %rax
               	leaq	-0xd8(%rbp), %rcx
               	addq	$0x2, %rcx
               	movswq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	leaq	-0xd8(%rbp), %rcx
               	addq	$0x4, %rcx
               	movswq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rdi
               	callq	<addr>
               	movw	%ax, (%rbx)
               	leaq	-0xd8(%rbp), %rax
               	addq	$0x6, %rax
               	movswq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xe0(%rbp), %rax
               	movl	$0x7, %ecx
               	movw	%cx, (%rax)
               	leaq	-0xe0(%rbp), %rax
               	addq	$0x2, %rax
               	movabsq	$-0x7, %rcx
               	movw	%cx, (%rax)
               	leaq	-0xe0(%rbp), %rax
               	addq	$0x4, %rax
               	movl	$0xc0de, %ecx           # imm = 0xC0DE
               	movw	%cx, (%rax)
               	leaq	-0xe0(%rbp), %rax
               	movswq	(%rax), %rax
               	leaq	-0xe0(%rbp), %rcx
               	addq	$0x2, %rcx
               	movswq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xe0(%rbp), %rax
               	addq	$0x4, %rax
               	movzwq	(%rax), %rax
               	xorq	$0xc0de, %rax           # imm = 0xC0DE
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
