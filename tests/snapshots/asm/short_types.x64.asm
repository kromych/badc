
short_types.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003fa <.text+0x17a>
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
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	0x400305 <.text+0x85>
               	leaq	0xfe1d(%rip), %r9       # 0x4100f8
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
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
               	leaq	0xfdfd(%rip), %rdi      # 0x410110
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	0xfdee(%rip), %rdi      # 0x410116
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	0xfde0(%rip), %rdi      # 0x41011d
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400cf7 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400387 <.text+0x107>
               	leaq	0xfd86(%rip), %r14      # 0x4100f8
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	0x400387 <.text+0x107>
               	leaq	0xfd6a(%rip), %r12      # 0x4100f8
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	%edi, %r11
               	andq	$0xffff, %r11           # imm = 0xFFFF
               	movslq	%r11d, %r9
               	andq	$0x8000, %r9            # imm = 0x8000
               	cmpq	$0x0, %r9
               	je	0x4003e5 <.text+0x165>
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
               	subq	$0x100, %rsp            # imm = 0x100
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x4d2, %r11d           # imm = 0x4D2
               	movabsq	$-0x2a, %r9
               	movswq	%r11w, %r8
               	cmpq	$0x4d2, %r8             # imm = 0x4D2
               	je	0x400460 <.text+0x1e0>
               	movl	$0x1, %edi
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
               	cmpq	$-0x2a, %r8
               	je	0x400498 <.text+0x218>
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
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	movswq	%r8w, %r8
               	cmpq	$0x4a8, %r8             # imm = 0x4A8
               	je	0x4004de <.text+0x25e>
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
               	movswq	%r11w, %r8
               	movswq	%r9w, %rdi
               	subq	%rdi, %r8
               	movslq	%r8d, %r8
               	movswq	%r8w, %r8
               	cmpq	$0x4fc, %r8             # imm = 0x4FC
               	je	0x400524 <.text+0x2a4>
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
               	movswq	%r9w, %r9
               	movl	$0x3, %r10d
               	imulq	%r10, %r9
               	movslq	%r9d, %r9
               	movswq	%r9w, %r9
               	cmpq	$-0x7e, %r9
               	je	0x40056d <.text+0x2ed>
               	movl	$0x5, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movswq	%r11w, %r9
               	movl	$0x7, %edi
               	movq	%rdi, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movswq	%r9w, %r9
               	cmpq	$0xb0, %r9
               	je	0x4005c0 <.text+0x340>
               	movl	$0x6, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movswq	%r11w, %r11
               	movl	$0x7, %edi
               	movq	%rdi, %r10
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
               	je	0x400613 <.text+0x393>
               	movl	$0x7, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movl	$0x1, %ebx
               	movswq	%bx, %rdi
               	shlq	$0xe, %rdi
               	movswq	%di, %rdi
               	cmpq	$0x4000, %rdi           # imm = 0x4000
               	je	0x400659 <.text+0x3d9>
               	movl	$0x8, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movswq	%bx, %rdi
               	movq	%rdi, %r12
               	shlq	$0x10, %r12
               	movq	%r12, %rdi
               	callq	0x4003b6 <.text+0x136>
               	movswq	%ax, %rax
               	cmpq	$0x0, %rax
               	je	0x4006a5 <.text+0x425>
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
               	movswq	%bx, %rbx
               	shlq	$0xf, %rbx
               	movq	%rbx, %rdi
               	callq	0x4003b6 <.text+0x136>
               	movswq	%ax, %rax
               	cmpq	$-0x8000, %rax          # imm = 0x8000
               	je	0x4006ed <.text+0x46d>
               	movl	$0xa, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movabsq	$-0x8, %rax
               	movswq	%ax, %rax
               	sarq	$0x1, %rax
               	movswq	%ax, %rax
               	cmpq	$-0x4, %rax
               	je	0x400737 <.text+0x4b7>
               	movl	$0xb, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movl	$0xfffe, %r14d          # imm = 0xFFFE
               	movl	$0x1, %r15d
               	movq	%r14, %r12
               	andq	$0xffff, %r12           # imm = 0xFFFF
               	movq	%r15, %r8
               	andq	$0xffff, %r8            # imm = 0xFFFF
               	addq	%r8, %r12
               	movslq	%r12d, %r12
               	movslq	%r12d, %r12
               	movq	%r12, %rdi
               	callq	0x4003ec <.text+0x16c>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	$0xffff, %rax           # imm = 0xFFFF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4007b4 <.text+0x534>
               	movl	$0xc, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	andq	$0xffff, %r14           # imm = 0xFFFF
               	movq	%r15, %r12
               	andq	$0xffff, %r12           # imm = 0xFFFF
               	addq	%r12, %r14
               	movslq	%r14d, %r14
               	addq	$0x1, %r14
               	movslq	%r14d, %r14
               	movq	%r14, %rdi
               	callq	0x4003ec <.text+0x16c>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400822 <.text+0x5a2>
               	movl	$0xd, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	movl	$0x1, %ebx
               	movq	%rbx, %r12
               	andq	$0xffff, %r12           # imm = 0xFFFF
               	movswq	%ax, %rsi
               	addq	%rsi, %r12
               	movslq	%r12d, %r12
               	movslq	%r12d, %r12
               	cmpq	$0x0, %r12
               	je	0x40087c <.text+0x5fc>
               	movl	$0xe, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movswq	%ax, %r14
               	movq	%r14, %rdi
               	callq	0x4003ec <.text+0x16c>
               	movslq	%eax, %r14
               	cmpq	$0xffff, %r14           # imm = 0xFFFF
               	je	0x4008bf <.text+0x63f>
               	movl	$0xf, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movslq	%eax, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	andq	$0xffff, %rbx           # imm = 0xFFFF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	%rbx, %rax
               	ja	0x40090b <.text+0x68b>
               	movl	$0x10, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	andq	$0xffff, %r15           # imm = 0xFFFF
               	shlq	$0xf, %r15
               	movq	%r15, %rdi
               	callq	0x4003ec <.text+0x16c>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	$0x8000, %rax           # imm = 0x8000
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x40096a <.text+0x6ea>
               	movl	$0x11, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movl	$0x8000, %eax           # imm = 0x8000
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movslq	%eax, %rax
               	sarq	$0x1, %rax
               	movslq	%eax, %rax
               	cmpq	$0x4000, %rax           # imm = 0x4000
               	je	0x4009bc <.text+0x73c>
               	movl	$0x12, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0xd8(%rbp), %rax
               	movl	$0x64, %r15d
               	movw	%r15w, (%rax)
               	leaq	-0xd8(%rbp), %rbx
               	addq	$0x2, %rbx
               	movl	$0xc8, %r15d
               	movw	%r15w, (%rbx)
               	leaq	-0xd8(%rbp), %rax
               	addq	$0x4, %rax
               	movabsq	$-0x12c, %r15           # imm = 0xFED4
               	movw	%r15w, (%rax)
               	leaq	-0xd8(%rbp), %rbx
               	addq	$0x6, %rbx
               	leaq	-0xd8(%rbp), %r15
               	movswq	(%r15), %rax
               	leaq	-0xd8(%rbp), %r15
               	addq	$0x2, %r15
               	movswq	(%r15), %rsi
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	leaq	-0xd8(%rbp), %rsi
               	addq	$0x4, %rsi
               	movswq	(%rsi), %r15
               	addq	%r15, %rax
               	movslq	%eax, %r12
               	movq	%r12, %rdi
               	callq	0x4003b6 <.text+0x136>
               	movw	%ax, (%rbx)
               	leaq	-0xd8(%rbp), %r12
               	addq	$0x6, %r12
               	movswq	(%r12), %rax
               	cmpq	$0x0, %rax
               	je	0x400a9d <.text+0x81d>
               	movl	$0x13, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0xe0(%rbp), %rax
               	movl	$0x7, %r12d
               	movw	%r12w, (%rax)
               	leaq	-0xe0(%rbp), %rbx
               	addq	$0x2, %rbx
               	movabsq	$-0x7, %r12
               	movw	%r12w, (%rbx)
               	leaq	-0xe0(%rbp), %rax
               	addq	$0x4, %rax
               	movl	$0xc0de, %r12d          # imm = 0xC0DE
               	movw	%r12w, (%rax)
               	leaq	-0xe0(%rbp), %rbx
               	movswq	(%rbx), %r12
               	leaq	-0xe0(%rbp), %rbx
               	addq	$0x2, %rbx
               	movswq	(%rbx), %rax
               	addq	%rax, %r12
               	movslq	%r12d, %r12
               	cmpq	$0x0, %r12
               	je	0x400b39 <.text+0x8b9>
               	movl	$0x14, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0xe0(%rbp), %r12
               	addq	$0x4, %r12
               	movzwq	(%r12), %rax
               	xorq	$0xc0de, %rax           # imm = 0xC0DE
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400b91 <.text+0x911>
               	movl	$0x15, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
