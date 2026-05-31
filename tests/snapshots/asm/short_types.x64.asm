
short_types.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40041d <.text+0x19d>
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
               	callq	0x400db7 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x40039c <.text+0x11c>
               	leaq	0xfd74(%rip), %r14      # 0x4100f8
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x40039c <.text+0x11c>
               	leaq	0xfd55(%rip), %r12      # 0x4100f8
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	movq	%r12, %rbx
               	addq	%rsi, %rbx
               	movq	(%rbx), %rsi
               	movq	%rsi, %rcx
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
               	je	0x400408 <.text+0x188>
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
               	subq	$0x110, %rsp            # imm = 0x110
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x4d2, %r11d           # imm = 0x4D2
               	movabsq	$-0x2a, %r9
               	movswq	%r11w, %r8
               	cmpq	$0x4d2, %r8             # imm = 0x4D2
               	je	0x400484 <.text+0x204>
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	movswq	%r9w, %rdi
               	cmpq	$-0x2a, %rdi
               	je	0x4004bc <.text+0x23c>
               	movl	$0x2, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	movswq	%r11w, %r8
               	movswq	%r9w, %rdi
               	movq	%r8, %rsi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	movswq	%si, %rdi
               	cmpq	$0x4a8, %rdi            # imm = 0x4A8
               	je	0x400505 <.text+0x285>
               	movl	$0x3, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	movswq	%r11w, %rsi
               	movswq	%r9w, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movslq	%r8d, %r8
               	movswq	%r8w, %rdi
               	cmpq	$0x4fc, %rdi            # imm = 0x4FC
               	je	0x40054e <.text+0x2ce>
               	movl	$0x4, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	movswq	%r9w, %r8
               	movl	$0x3, %edi
               	imulq	%r8, %rdi
               	movslq	%edi, %rdi
               	movswq	%di, %r8
               	cmpq	$-0x7e, %r8
               	je	0x400597 <.text+0x317>
               	movl	$0x5, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
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
               	je	0x4005ec <.text+0x36c>
               	movl	$0x6, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
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
               	je	0x400641 <.text+0x3c1>
               	movl	$0x7, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	movl	$0x1, %ebx
               	movswq	%bx, %r8
               	movq	%r8, %r9
               	shlq	$0xe, %r9
               	movswq	%r9w, %r8
               	cmpq	$0x4000, %r8            # imm = 0x4000
               	je	0x40068a <.text+0x40a>
               	movl	$0x8, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	movswq	%bx, %r9
               	movq	%r9, %r12
               	shlq	$0x10, %r12
               	movq	%r12, %rdi
               	callq	0x4003d0 <.text+0x150>
               	movq	%rax, %r9
               	movswq	%r9w, %r12
               	cmpq	$0x0, %r12
               	je	0x4006d9 <.text+0x459>
               	movl	$0x9, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	movswq	%bx, %r9
               	movq	%r9, %r14
               	shlq	$0xf, %r14
               	movq	%r14, %rdi
               	callq	0x4003d0 <.text+0x150>
               	movq	%rax, %r9
               	movswq	%r9w, %r14
               	cmpq	$-0x8000, %r14          # imm = 0x8000
               	je	0x400728 <.text+0x4a8>
               	movl	$0xa, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	movabsq	$-0x8, %r9
               	movswq	%r9w, %r14
               	movq	%r14, %r9
               	sarq	$0x1, %r9
               	movswq	%r9w, %r14
               	cmpq	$-0x4, %r14
               	je	0x400776 <.text+0x4f6>
               	movl	$0xb, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	movl	$0xfffe, %r12d          # imm = 0xFFFE
               	movl	$0x1, %r10d
               	movq	%r10, 0x28(%rsp)
               	movq	%r12, %rbx
               	andq	$0xffff, %rbx           # imm = 0xFFFF
               	movq	0x28(%rsp), %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movq	%rbx, %rsi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	movslq	%esi, %r14
               	movq	%r14, %rdi
               	callq	0x40040f <.text+0x18f>
               	movq	%rax, %rsi
               	movq	%rsi, %r14
               	andq	$0xffff, %r14           # imm = 0xFFFF
               	movq	%r14, %rsi
               	xorq	$0xffff, %rsi           # imm = 0xFFFF
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rsi, %r14
               	cmpq	$0x0, %r14
               	je	0x400806 <.text+0x586>
               	movl	$0xc, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	movq	%r12, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movq	0x28(%rsp), %r14
               	andq	$0xffff, %r14           # imm = 0xFFFF
               	movq	%rsi, %r12
               	addq	%r14, %r12
               	movslq	%r12d, %r12
               	movq	%r12, %r14
               	addq	$0x1, %r14
               	movslq	%r14d, %rbx
               	movq	%rbx, %rdi
               	callq	0x40040f <.text+0x18f>
               	movq	%rax, %r12
               	movq	%r12, %rbx
               	andq	$0xffff, %rbx           # imm = 0xFFFF
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r12
               	cmpq	$0x0, %r12
               	je	0x400885 <.text+0x605>
               	movl	$0xd, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rbx
               	movl	$0x1, %r14d
               	movq	%r14, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movswq	%bx, %r12
               	movq	%rsi, %rdx
               	addq	%r12, %rdx
               	movslq	%edx, %rdx
               	movslq	%edx, %r12
               	cmpq	$0x0, %r12
               	je	0x4008e4 <.text+0x664>
               	movl	$0xe, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	movswq	%bx, %r15
               	movq	%r15, %rdi
               	callq	0x40040f <.text+0x18f>
               	movq	%rax, %r12
               	movslq	%r12d, %r15
               	cmpq	$0xffff, %r15           # imm = 0xFFFF
               	je	0x40092b <.text+0x6ab>
               	movl	$0xf, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	movslq	%r12d, %rbx
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r15
               	movq	%r14, %rbx
               	andq	$0xffff, %rbx           # imm = 0xFFFF
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r14
               	cmpq	%r14, %r15
               	ja	0x40097b <.text+0x6fb>
               	movl	$0x10, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	movq	0x28(%rsp), %rbx
               	andq	$0xffff, %rbx           # imm = 0xFFFF
               	movq	%rbx, %r12
               	shlq	$0xf, %r12
               	movq	%r12, %rdi
               	callq	0x40040f <.text+0x18f>
               	movq	%rax, %rbx
               	movq	%rbx, %r12
               	andq	$0xffff, %r12           # imm = 0xFFFF
               	movq	%r12, %rbx
               	xorq	$0x8000, %rbx           # imm = 0x8000
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r12
               	cmpq	$0x0, %r12
               	je	0x4009eb <.text+0x76b>
               	movl	$0x11, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	movl	$0x8000, %ebx           # imm = 0x8000
               	movq	%rbx, %r12
               	andq	$0xffff, %r12           # imm = 0xFFFF
               	movq	%r12, %rbx
               	andq	$0xffff, %rbx           # imm = 0xFFFF
               	movslq	%ebx, %r12
               	movq	%r12, %rbx
               	sarq	$0x1, %rbx
               	movslq	%ebx, %r12
               	cmpq	$0x4000, %r12           # imm = 0x4000
               	je	0x400a46 <.text+0x7c6>
               	movl	$0x12, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0xd8(%rbp), %rbx
               	movl	$0x64, %r12d
               	movw	%r12w, (%rbx)
               	leaq	-0xd8(%rbp), %r15
               	movq	%r15, %r12
               	addq	$0x2, %r12
               	movl	$0xc8, %r15d
               	movw	%r15w, (%r12)
               	leaq	-0xd8(%rbp), %rbx
               	movq	%rbx, %r15
               	addq	$0x4, %r15
               	movabsq	$-0x12c, %rbx           # imm = 0xFED4
               	movw	%bx, (%r15)
               	leaq	-0xd8(%rbp), %r12
               	movq	%r12, %r14
               	addq	$0x6, %r14
               	leaq	-0xd8(%rbp), %r12
               	movswq	(%r12), %r15
               	leaq	-0xd8(%rbp), %r12
               	movq	%r12, %rbx
               	addq	$0x2, %rbx
               	movswq	(%rbx), %r12
               	movq	%r15, %rbx
               	addq	%r12, %rbx
               	movslq	%ebx, %rbx
               	leaq	-0xd8(%rbp), %r12
               	movq	%r12, %r15
               	addq	$0x4, %r15
               	movswq	(%r15), %r12
               	movq	%rbx, %r15
               	addq	%r12, %r15
               	movslq	%r15d, %rbx
               	movq	%rbx, %rdi
               	callq	0x4003d0 <.text+0x150>
               	movq	%rax, %r12
               	movw	%r12w, (%r14)
               	leaq	-0xd8(%rbp), %rbx
               	movq	%rbx, %r12
               	addq	$0x6, %r12
               	movswq	(%r12), %rbx
               	cmpq	$0x0, %rbx
               	je	0x400b44 <.text+0x8c4>
               	movl	$0x13, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0xe0(%rbp), %r12
               	movl	$0x7, %ebx
               	movw	%bx, (%r12)
               	leaq	-0xe0(%rbp), %r14
               	movq	%r14, %rbx
               	addq	$0x2, %rbx
               	movabsq	$-0x7, %r14
               	movw	%r14w, (%rbx)
               	leaq	-0xe0(%rbp), %r12
               	movq	%r12, %r14
               	addq	$0x4, %r14
               	movl	$0xc0de, %r12d          # imm = 0xC0DE
               	movw	%r12w, (%r14)
               	leaq	-0xe0(%rbp), %rbx
               	movswq	(%rbx), %r12
               	leaq	-0xe0(%rbp), %rbx
               	movq	%rbx, %r14
               	addq	$0x2, %r14
               	movswq	(%r14), %rbx
               	movq	%r12, %r14
               	addq	%rbx, %r14
               	movslq	%r14d, %r14
               	cmpq	$0x0, %r14
               	je	0x400bed <.text+0x96d>
               	movl	$0x14, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0xe0(%rbp), %rbx
               	movq	%rbx, %r14
               	addq	$0x4, %r14
               	movzwq	(%r14), %rbx
               	movq	%rbx, %r14
               	xorq	$0xc0de, %r14           # imm = 0xC0DE
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r14, %rbx
               	cmpq	$0x0, %rbx
               	je	0x400c48 <.text+0x9c8>
               	movl	$0x15, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	movl	$0x2a, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
