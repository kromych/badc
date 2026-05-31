
local_array_partial_init_zero.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003d5 <.text+0x1b5>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	movq	%rdi, %r11
               	xorq	%r9, %r9
               	movl	%r9d, -0xa8(%rbp)
               	jmp	0x400254 <.text+0x34>
               	movslq	-0xa8(%rbp), %r9
               	cmpq	$0x28, %r9
               	jge	0x4002b5 <.text+0x95>
               	jmp	0x400289 <.text+0x69>
               	leaq	-0xa8(%rbp), %r9
               	movslq	(%r9), %r8
               	movq	%r8, %rdi
               	addq	$0x1, %rdi
               	movl	%edi, (%r9)
               	jmp	0x400254 <.text+0x34>
               	leaq	-0xa0(%rbp), %rdi
               	movslq	-0xa8(%rbp), %r8
               	movq	%r8, %r9
               	shlq	$0x2, %r9
               	movq	%rdi, %r8
               	addq	%r9, %r8
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	movl	%r9d, (%r8)
               	jmp	0x40026d <.text+0x4d>
               	xorq	%rax, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	leaq	-0x68(%rbp), %r11
               	leaq	0xfdf9(%rip), %r9       # 0x4100d0
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	movq	0x8(%r9), %rax
               	movq	%rax, 0x8(%r11)
               	movq	0x10(%r9), %rax
               	movq	%rax, 0x10(%r11)
               	movq	0x18(%r9), %rax
               	movq	%rax, 0x18(%r11)
               	movq	0x20(%r9), %rax
               	movq	%rax, 0x20(%r11)
               	movq	0x28(%r9), %rax
               	movq	%rax, 0x28(%r11)
               	movq	0x30(%r9), %rax
               	movq	%rax, 0x30(%r11)
               	movq	0x38(%r9), %rax
               	movq	%rax, 0x38(%r11)
               	movq	0x40(%r9), %rax
               	movq	%rax, 0x40(%r11)
               	movq	0x48(%r9), %rax
               	movq	%rax, 0x48(%r11)
               	movq	0x50(%r9), %rax
               	movq	%rax, 0x50(%r11)
               	movq	0x58(%r9), %rax
               	movq	%rax, 0x58(%r11)
               	movzbq	0x60(%r9), %rax
               	movb	%al, 0x60(%r11)
               	movzbq	0x61(%r9), %rax
               	movb	%al, 0x61(%r11)
               	movzbq	0x62(%r9), %rax
               	movb	%al, 0x62(%r11)
               	movzbq	0x63(%r9), %rax
               	movb	%al, 0x63(%r11)
               	popq	%rax
               	movq	%r11, %r8
               	xorq	%r8, %r8
               	movl	%r8d, -0x70(%rbp)
               	movl	%r8d, -0x78(%rbp)
               	jmp	0x40036e <.text+0x14e>
               	movslq	-0x78(%rbp), %r8
               	cmpq	$0x19, %r8
               	jge	0x4003c9 <.text+0x1a9>
               	jmp	0x40039d <.text+0x17d>
               	leaq	-0x78(%rbp), %r8
               	movslq	(%r8), %r9
               	movq	%r9, %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r8)
               	jmp	0x40036e <.text+0x14e>
               	leaq	-0x70(%rbp), %r11
               	movl	(%r11), %r9d
               	leaq	-0x68(%rbp), %r8
               	movslq	-0x78(%rbp), %rdi
               	movq	%rdi, %rsi
               	shlq	$0x2, %rsi
               	movq	%r8, %rdi
               	addq	%rsi, %rdi
               	movl	(%rdi), %esi
               	movq	%r9, %rdi
               	addq	%rsi, %rdi
               	movl	%edi, (%r11)
               	jmp	0x400384 <.text+0x164>
               	movl	-0x70(%rbp), %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movl	$0xdeadbeef, %ebx       # imm = 0xDEADBEEF
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r9
               	callq	0x4002c1 <.text+0xa1>
               	movq	%rax, %r12
               	movl	$0x12345678, %r14d      # imm = 0x12345678
               	movq	%r14, %rdi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r8
               	callq	0x4002c1 <.text+0xa1>
               	movq	%rax, %r8
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%r12, %r14
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%r14, %r12
               	cmpq	$0x0, %r12
               	je	0x400461 <.text+0x241>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%r8, %r14
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%r14, %r12
               	cmpq	$0x0, %r12
               	je	0x4004a3 <.text+0x283>
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
