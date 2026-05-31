
extern_decl_then_define.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40023f <.text+0x1f>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	leaq	0xfed2(%rip), %rax      # 0x410110
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	0xfe76(%rip), %r11      # 0x4100d0
               	leaq	0xfe8f(%rip), %r9       # 0x4100f0
               	cmpq	%r9, %r11
               	jne	0x400288 <.text+0x68>
               	movl	$0x1, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfe41(%rip), %r8       # 0x4100d0
               	movl	(%r8), %r9d
               	movl	$0xc1059ed8, %r11d      # imm = 0xC1059ED8
               	movq	%r9, %r8
               	cmpq	%r11, %r9
               	je	0x4002c2 <.text+0xa2>
               	movl	$0x2, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfe27(%rip), %r8       # 0x4100f0
               	movl	(%r8), %r9d
               	cmpq	$0x6a09e667, %r9        # imm = 0x6A09E667
               	je	0x4002f7 <.text+0xd7>
               	movl	$0x3, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfdd2(%rip), %r8       # 0x4100d0
               	movq	%r8, %r9
               	addq	$0x1c, %r9
               	movl	(%r9), %r8d
               	movl	$0xbefa4fa4, %r11d      # imm = 0xBEFA4FA4
               	movq	%r8, %r9
               	cmpq	%r11, %r8
               	je	0x40033b <.text+0x11b>
               	movl	$0x4, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfdae(%rip), %r9       # 0x4100f0
               	movq	%r9, %r8
               	addq	$0x1c, %r8
               	movl	(%r8), %r9d
               	cmpq	$0x5be0cd19, %r9        # imm = 0x5BE0CD19
               	je	0x400379 <.text+0x159>
               	movl	$0x5, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	0x400237 <.text+0x17>
               	leaq	0xfd8b(%rip), %rbx      # 0x410110
               	cmpq	%rbx, %rax
               	je	0x4003ac <.text+0x18c>
               	movl	$0x6, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	0x400237 <.text+0x17>
               	movl	(%rax), %r12d
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	movq	%r12, %rax
               	cmpq	%r11, %r12
               	je	0x4003e3 <.text+0x1c3>
               	movl	$0x7, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rbx
               	addq	$0x8, %rbx
               	movq	(%rbx), %rax
               	movl	$0xdeadbeef, %r11d      # imm = 0xDEADBEEF
               	movq	%rax, %rbx
               	cmpq	%r11, %rax
               	je	0x400424 <.text+0x204>
               	movl	$0x8, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
