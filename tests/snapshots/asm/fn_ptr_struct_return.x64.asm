
fn_ptr_struct_return.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400252 <.text+0x22>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100d0
               	movslq	%edi, %r11
               	leaq	0xfe8f(%rip), %rax      # 0x4100e0
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%rbx, %rbx
               	leaq	0xfe6e(%rip), %r9       # 0x4100e8
               	movq	(%r9), %r12
               	movq	%r12, %r11
               	movq	%rbx, %rdi
               	callq	*%r11
               	cmpq	$0x0, %rax
               	jne	0x4002ba <.text+0x8a>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfe27(%rip), %r14      # 0x4100e8
               	movq	(%r14), %r12
               	xorq	%r15, %r15
               	movq	%r12, %r11
               	movq	%r15, %rdi
               	callq	*%r11
               	cmpq	$0x0, %rax
               	jne	0x400304 <.text+0xd4>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movq	(%r14), %rbx
               	xorq	%r15, %r15
               	movq	%rbx, %r11
               	movq	%r15, %rdi
               	callq	*%r11
               	cmpq	$0x0, %rax
               	jne	0x400347 <.text+0x117>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x107(%rip), %r14      # 0x400247 <.text+0x17>
               	xorq	%r15, %r15
               	movq	%r14, %r11
               	movq	%r15, %rdi
               	callq	*%r11
               	cmpq	$0x0, %rax
               	jne	0x40038e <.text+0x15e>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%r14, %r11
               	movq	%rbx, %rdi
               	callq	*%r11
               	cmpq	$0x0, %rax
               	jne	0x4003ce <.text+0x19e>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd13(%rip), %rbx      # 0x4100e8
               	movq	(%rbx), %r15
               	xorq	%r12, %r12
               	movq	%r15, %r11
               	movq	%r12, %rdi
               	callq	*%r11
               	cmpq	$0x0, %rax
               	jne	0x400418 <.text+0x1e8>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
