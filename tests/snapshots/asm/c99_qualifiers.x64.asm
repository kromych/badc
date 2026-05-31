
c99_qualifiers.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002b1 <.text+0x91>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movslq	%edi, %r11
               	movq	%rsi, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	addq	%r9, %r11
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	xorq	%r8, %r8
               	movl	%r8d, -0x8(%rbp)
               	movq	%r8, -0x10(%rbp)
               	jmp	0x400273 <.text+0x53>
               	movq	-0x10(%rbp), %r8
               	cmpq	%r9, %r8
               	jae	0x4002a4 <.text+0x84>
               	movslq	-0x8(%rbp), %rdi
               	movslq	(%r11), %r8
               	addq	%r8, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x8(%rbp)
               	movq	-0x10(%rbp), %r8
               	addq	$0x1, %r8
               	movq	%r8, -0x10(%rbp)
               	jmp	0x400273 <.text+0x53>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x7, %r11d
               	movl	%r11d, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rbx
               	movl	$0x1, %r12d
               	movl	$0x2, %r14d
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x3, %rax
               	je	0x400329 <.text+0x109>
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	callq	0x400252 <.text+0x32>
               	cmpq	$0x7, %rax
               	je	0x40036f <.text+0x14f>
               	movl	$0x2, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd72(%rip), %rax      # 0x4100e8
               	movzbq	(%rax), %r15
               	xorq	$0x62, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	je	0x4003be <.text+0x19e>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	je	0x4003f5 <.text+0x1d5>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	je	0x40042c <.text+0x20c>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	je	0x400463 <.text+0x243>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc6e(%rip), %r15      # 0x4100d8
               	movl	$0x1, %eax
               	movl	%eax, (%r15)
               	movl	(%r15), %ebx
               	xorq	$0x1, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	je	0x4004ba <.text+0x29a>
               	movl	$0x7, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
