
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
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%rdi, %rdi
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %r8
               	movq	%r8, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rsi
               	movq	(%rsi), %r8
               	movq	%r8, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %r8
               	movq	(%rax), %rax
               	movq	%rax, (%r8)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	%edi, %r11
               	andq	$0xffff, %r11           # imm = 0xFFFF
               	movslq	%r11d, %r9
               	andq	$0x8000, %r9            # imm = 0x8000
               	cmpq	$0x0, %r9
               	je	<addr>
               	movslq	%r11d, %r8
               	subq	$0x10000, %r8           # imm = 0x10000
               	movslq	%r8d, %rax
               	retq
               	movslq	%r11d, %r8
               	movq	%r8, %rax
               	retq
               	movslq	%edi, %r11
               	movq	%r11, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x4d2, %r11d           # imm = 0x4D2
               	movabsq	$-0x2a, %r9
               	cmpq	$0x4d2, %r11            # imm = 0x4D2
               	je	<addr>
               	movl	$0x1, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$-0x2a, %r9
               	je	<addr>
               	movl	$0x2, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %r8
               	addq	%r9, %r8
               	movslq	%r8d, %r8
               	movswq	%r8w, %r8
               	cmpq	$0x4a8, %r8             # imm = 0x4A8
               	je	<addr>
               	movl	$0x3, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %r8
               	subq	%r9, %r8
               	movslq	%r8d, %r8
               	movswq	%r8w, %r8
               	cmpq	$0x4fc, %r8             # imm = 0x4FC
               	je	<addr>
               	movl	$0x4, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %r10d
               	imulq	%r10, %r9
               	movslq	%r9d, %r9
               	movswq	%r9w, %r9
               	cmpq	$-0x7e, %r9
               	je	<addr>
               	movl	$0x5, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %r9d
               	movq	%r9, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movswq	%r8w, %r8
               	cmpq	$0xb0, %r8
               	je	<addr>
               	movl	$0x6, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %r8d
               	movq	%r8, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %r11
               	popq	%rdx
               	popq	%rax
               	movswq	%r11w, %r11
               	cmpq	$0x2, %r11
               	je	<addr>
               	movl	$0x7, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ebx
               	movq	%rbx, %r8
               	shlq	$0xe, %r8
               	movswq	%r8w, %r8
               	cmpq	$0x4000, %r8            # imm = 0x4000
               	je	<addr>
               	movl	$0x8, %r9d
               	movq	%r9, %rcx
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
               	movl	$0x9, %edi
               	movq	%rdi, %rcx
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
               	movl	$0xa, %edi
               	movq	%rdi, %rcx
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
               	movl	$0xb, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xfffe, %eax           # imm = 0xFFFE
               	movl	$0x1, %edi
               	movq	%rax, %rbx
               	addq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	movslq	%ebx, %rbx
               	andq	$0xffff, %rbx           # imm = 0xFFFF
               	andq	$0xffff, %rbx           # imm = 0xFFFF
               	xorq	$0xffff, %rbx           # imm = 0xFFFF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movl	$0xc, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xd, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	movl	$0x1, %ebx
               	movq	%rbx, %r8
               	addq	%rax, %r8
               	movslq	%r8d, %r8
               	movslq	%r8d, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0xe, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movslq	%eax, %r8
               	cmpq	$0xffff, %r8            # imm = 0xFFFF
               	je	<addr>
               	movl	$0xf, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movslq	%eax, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	%rbx, %rax
               	ja	<addr>
               	movl	$0x10, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	shlq	$0xf, %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	xorq	$0x8000, %rdi           # imm = 0x8000
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0x11, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8000, %edi           # imm = 0x8000
               	movslq	%edi, %rdi
               	sarq	$0x1, %rdi
               	movslq	%edi, %rdi
               	cmpq	$0x4000, %rdi           # imm = 0x4000
               	je	<addr>
               	movl	$0x12, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xd8(%rbp), %rdi
               	movl	$0x64, %eax
               	movw	%ax, (%rdi)
               	leaq	-0xd8(%rbp), %rbx
               	addq	$0x2, %rbx
               	movl	$0xc8, %eax
               	movw	%ax, (%rbx)
               	leaq	-0xd8(%rbp), %rdi
               	addq	$0x4, %rdi
               	movabsq	$-0x12c, %rax           # imm = 0xFED4
               	movw	%ax, (%rdi)
               	leaq	-0xd8(%rbp), %rbx
               	addq	$0x6, %rbx
               	leaq	-0xd8(%rbp), %rax
               	movswq	(%rax), %rax
               	leaq	-0xd8(%rbp), %rdi
               	addq	$0x2, %rdi
               	movswq	(%rdi), %rdi
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	leaq	-0xd8(%rbp), %rdi
               	addq	$0x4, %rdi
               	movswq	(%rdi), %rdi
               	addq	%rdi, %rax
               	movslq	%eax, %rdi
               	callq	<addr>
               	movw	%ax, (%rbx)
               	leaq	-0xd8(%rbp), %rdi
               	addq	$0x6, %rdi
               	movswq	(%rdi), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0x13, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xe0(%rbp), %rdi
               	movl	$0x7, %eax
               	movw	%ax, (%rdi)
               	leaq	-0xe0(%rbp), %rbx
               	addq	$0x2, %rbx
               	movabsq	$-0x7, %rax
               	movw	%ax, (%rbx)
               	leaq	-0xe0(%rbp), %rdi
               	addq	$0x4, %rdi
               	movl	$0xc0de, %eax           # imm = 0xC0DE
               	movw	%ax, (%rdi)
               	leaq	-0xe0(%rbp), %rbx
               	movswq	(%rbx), %rbx
               	leaq	-0xe0(%rbp), %rax
               	addq	$0x2, %rax
               	movswq	(%rax), %rax
               	addq	%rax, %rbx
               	movslq	%ebx, %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movl	$0x14, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xe0(%rbp), %rbx
               	addq	$0x4, %rbx
               	movzwq	(%rbx), %rbx
               	xorq	$0xc0de, %rbx           # imm = 0xC0DE
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movl	$0x15, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
