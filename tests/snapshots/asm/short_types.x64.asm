
short_types.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40041a <.text+0x19a>
               	movq	%rax, %rdi
               	callq	*0xfe51(%rip)           # 0x4100e8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfe3e(%rip), %r9       # 0x4100f8
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40030b <.text+0x8b>
               	leaq	0xfe1a(%rip), %rdi      # 0x4100f8
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%rdi, %r9
               	addq	%r8, %r9
               	movq	(%r9), %r8
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
               	leaq	0xfdf7(%rip), %rdi      # 0x410110
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfde5(%rip), %rsi      # 0x410116
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfdd4(%rip), %r9       # 0x41011d
               	movq	%r9, (%rsi)
               	leaq	-0x18(%rbp), %rdi
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	movq	%rdi, %rsi
               	addq	%r9, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400d87 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400399 <.text+0x119>
               	leaq	0xfd77(%rip), %r14      # 0x4100f8
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rax), %r12
               	movq	%r12, (%rdi)
               	jmp	0x400399 <.text+0x119>
               	leaq	0xfd58(%rip), %r12      # 0x4100f8
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	movq	%r12, %rbx
               	addq	%rax, %rbx
               	movq	(%rbx), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	%edi, %r11
               	movq	%r11, %r9
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	movslq	%r9d, %r11
               	movq	%r11, %r8
               	andq	$0x8000, %r8            # imm = 0x8000
               	cmpq	$0x0, %r8
               	je	0x400405 <.text+0x185>
               	movslq	%r9d, %r11
               	movq	%r11, %r8
               	subq	$0x10000, %r8           # imm = 0x10000
               	movslq	%r8d, %rax
               	retq
               	movslq	%r9d, %r11
               	movq	%r11, %rax
               	retq
               	movslq	%edi, %r11
               	movq	%r11, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x4d2, %r11d           # imm = 0x4D2
               	movabsq	$-0x2a, %r9
               	movswq	%r11w, %r8
               	cmpq	$0x4d2, %r8             # imm = 0x4D2
               	je	0x400481 <.text+0x201>
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movswq	%r9w, %rdi
               	cmpq	$-0x2a, %rdi
               	je	0x4004b9 <.text+0x239>
               	movl	$0x2, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movswq	%r11w, %r8
               	movswq	%r9w, %rdi
               	movq	%r8, %rsi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	movswq	%si, %rdi
               	cmpq	$0x4a8, %rdi            # imm = 0x4A8
               	je	0x400502 <.text+0x282>
               	movl	$0x3, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movswq	%r11w, %rsi
               	movswq	%r9w, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movslq	%r8d, %r8
               	movswq	%r8w, %rdi
               	cmpq	$0x4fc, %rdi            # imm = 0x4FC
               	je	0x40054b <.text+0x2cb>
               	movl	$0x4, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movswq	%r9w, %r8
               	movl	$0x3, %edi
               	imulq	%r8, %rdi
               	movslq	%edi, %rdi
               	movswq	%di, %r8
               	cmpq	$-0x7e, %r8
               	je	0x400594 <.text+0x314>
               	movl	$0x5, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movswq	%r11w, %rdi
               	movl	$0x7, %r8d
               	movq	%r8, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movswq	%r9w, %r8
               	cmpq	$0xb0, %r8
               	je	0x4005e9 <.text+0x369>
               	movl	$0x6, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movswq	%r11w, %r9
               	movl	$0x7, %r8d
               	movq	%r8, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %r11
               	popq	%rdx
               	popq	%rax
               	movswq	%r11w, %r8
               	cmpq	$0x2, %r8
               	je	0x40063e <.text+0x3be>
               	movl	$0x7, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movl	$0x1, %ebx
               	movswq	%bx, %r8
               	movq	%r8, %r9
               	shlq	$0xe, %r9
               	movswq	%r9w, %r8
               	cmpq	$0x4000, %r8            # imm = 0x4000
               	je	0x400687 <.text+0x407>
               	movl	$0x8, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movswq	%bx, %r9
               	movq	%r9, %r12
               	shlq	$0x10, %r12
               	movq	%r12, %rdi
               	callq	0x4003cd <.text+0x14d>
               	movswq	%ax, %r12
               	cmpq	$0x0, %r12
               	je	0x4006d3 <.text+0x453>
               	movl	$0x9, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movswq	%bx, %rax
               	movq	%rax, %r14
               	shlq	$0xf, %r14
               	movq	%r14, %rdi
               	callq	0x4003cd <.text+0x14d>
               	movswq	%ax, %r14
               	cmpq	$-0x8000, %r14          # imm = 0x8000
               	je	0x40071f <.text+0x49f>
               	movl	$0xa, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movabsq	$-0x8, %rax
               	movswq	%ax, %r14
               	movq	%r14, %rax
               	sarq	$0x1, %rax
               	movswq	%ax, %r14
               	cmpq	$-0x4, %r14
               	je	0x40076d <.text+0x4ed>
               	movl	$0xb, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movl	$0xfffe, %r12d          # imm = 0xFFFE
               	movl	$0x1, %r15d
               	movq	%r12, %rbx
               	andq	$0xffff, %rbx           # imm = 0xFFFF
               	movq	%r15, %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movq	%rbx, %rsi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	movslq	%esi, %r14
               	movq	%r14, %rdi
               	callq	0x40040c <.text+0x18c>
               	movq	%rax, %r14
               	andq	$0xffff, %r14           # imm = 0xFFFF
               	movq	%r14, %rax
               	xorq	$0xffff, %rax           # imm = 0xFFFF
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rax, %r14
               	cmpq	$0x0, %r14
               	je	0x4007f3 <.text+0x573>
               	movl	$0xc, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movq	%r12, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%r15, %r14
               	andq	$0xffff, %r14           # imm = 0xFFFF
               	movq	%rax, %r12
               	addq	%r14, %r12
               	movslq	%r12d, %r12
               	movq	%r12, %r14
               	addq	$0x1, %r14
               	movslq	%r14d, %rbx
               	movq	%rbx, %rdi
               	callq	0x40040c <.text+0x18c>
               	movq	%rax, %rbx
               	andq	$0xffff, %rbx           # imm = 0xFFFF
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rbx, %rax
               	cmpq	$0x0, %rax
               	je	0x40086b <.text+0x5eb>
               	movl	$0xd, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rbx
               	movl	$0x1, %r14d
               	movq	%r14, %r12
               	andq	$0xffff, %r12           # imm = 0xFFFF
               	movswq	%bx, %rax
               	movq	%r12, %rdx
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	movslq	%edx, %rax
               	cmpq	$0x0, %rax
               	je	0x4008c9 <.text+0x649>
               	movl	$0xe, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movswq	%bx, %r12
               	movq	%r12, %rdi
               	callq	0x40040c <.text+0x18c>
               	movslq	%eax, %r12
               	cmpq	$0xffff, %r12           # imm = 0xFFFF
               	je	0x40090d <.text+0x68d>
               	movl	$0xf, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movslq	%eax, %rbx
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r12
               	movq	%r14, %rbx
               	andq	$0xffff, %rbx           # imm = 0xFFFF
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r14
               	cmpq	%r14, %r12
               	ja	0x40095d <.text+0x6dd>
               	movl	$0x10, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movq	%r15, %rbx
               	andq	$0xffff, %rbx           # imm = 0xFFFF
               	movq	%rbx, %r12
               	shlq	$0xf, %r12
               	movq	%r12, %rdi
               	callq	0x40040c <.text+0x18c>
               	movq	%rax, %r12
               	andq	$0xffff, %r12           # imm = 0xFFFF
               	movq	%r12, %rax
               	xorq	$0x8000, %rax           # imm = 0x8000
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rax, %r12
               	cmpq	$0x0, %r12
               	je	0x4009c8 <.text+0x748>
               	movl	$0x11, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movl	$0x8000, %eax           # imm = 0x8000
               	movq	%rax, %r12
               	andq	$0xffff, %r12           # imm = 0xFFFF
               	movq	%r12, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movslq	%eax, %r12
               	movq	%r12, %rax
               	sarq	$0x1, %rax
               	movslq	%eax, %r12
               	cmpq	$0x4000, %r12           # imm = 0x4000
               	je	0x400a23 <.text+0x7a3>
               	movl	$0x12, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0xd8(%rbp), %rax
               	movl	$0x64, %r12d
               	movw	%r12w, (%rax)
               	leaq	-0xd8(%rbp), %r15
               	movq	%r15, %r12
               	addq	$0x2, %r12
               	movl	$0xc8, %r15d
               	movw	%r15w, (%r12)
               	leaq	-0xd8(%rbp), %rax
               	movq	%rax, %r15
               	addq	$0x4, %r15
               	movabsq	$-0x12c, %rax           # imm = 0xFED4
               	movw	%ax, (%r15)
               	leaq	-0xd8(%rbp), %r12
               	movq	%r12, %rbx
               	addq	$0x6, %rbx
               	leaq	-0xd8(%rbp), %r12
               	movswq	(%r12), %r15
               	leaq	-0xd8(%rbp), %r12
               	movq	%r12, %r14
               	addq	$0x2, %r14
               	movswq	(%r14), %r12
               	movq	%r15, %r14
               	addq	%r12, %r14
               	movslq	%r14d, %r14
               	leaq	-0xd8(%rbp), %r12
               	movq	%r12, %r15
               	addq	$0x4, %r15
               	movswq	(%r15), %r12
               	movq	%r14, %r15
               	addq	%r12, %r15
               	movslq	%r15d, %r14
               	movq	%r14, %rdi
               	callq	0x4003cd <.text+0x14d>
               	movw	%ax, (%rbx)
               	leaq	-0xd8(%rbp), %r14
               	movq	%r14, %rax
               	addq	$0x6, %rax
               	movswq	(%rax), %r14
               	cmpq	$0x0, %r14
               	je	0x400b1d <.text+0x89d>
               	movl	$0x13, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0xe0(%rbp), %rax
               	movl	$0x7, %r14d
               	movw	%r14w, (%rax)
               	leaq	-0xe0(%rbp), %rbx
               	movq	%rbx, %r14
               	addq	$0x2, %r14
               	movabsq	$-0x7, %rbx
               	movw	%bx, (%r14)
               	leaq	-0xe0(%rbp), %rax
               	movq	%rax, %rbx
               	addq	$0x4, %rbx
               	movl	$0xc0de, %eax           # imm = 0xC0DE
               	movw	%ax, (%rbx)
               	leaq	-0xe0(%rbp), %r14
               	movswq	(%r14), %rax
               	leaq	-0xe0(%rbp), %r14
               	movq	%r14, %rbx
               	addq	$0x2, %rbx
               	movswq	(%rbx), %r14
               	movq	%rax, %rbx
               	addq	%r14, %rbx
               	movslq	%ebx, %rbx
               	cmpq	$0x0, %rbx
               	je	0x400bc3 <.text+0x943>
               	movl	$0x14, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0xe0(%rbp), %r14
               	movq	%r14, %rbx
               	addq	$0x4, %rbx
               	movzwq	(%rbx), %r14
               	movq	%r14, %rbx
               	xorq	$0xc0de, %rbx           # imm = 0xC0DE
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r14
               	cmpq	$0x0, %r14
               	je	0x400c20 <.text+0x9a0>
               	movl	$0x15, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movl	$0x2a, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
